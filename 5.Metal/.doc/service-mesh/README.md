# [Istio](https://istio.io) Service Mesh


## :gear: [Install Isio](https://istio.io/latest/docs/setup/install/istioctl)


- [ ] [Install Istio using the default profile](https://istio.io/latest/docs/setup/install/istioctl/#install-istio-using-the-default-profile)

* Create the manifest using [apiVersion: install.istio.io/v1alpha1](https://istio.io/latest/docs/reference/config/istio.operator.v1alpha1)
* Along with [Istioctl ignoring my custom annotation for AWS NLB #24490](https://github.com/istio/istio/issues/24490)

```yaml
cat << EOF > ingress-gateways-k8s.yaml
# ingress-gateways-k8s.yaml
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  components:
    ingressGateways:
      - name: istio-ingressgateway
        enabled: true
        k8s:
          serviceAnnotations:
            service.beta.kubernetes.io/aws-load-balancer-type: "nlb"
  meshConfig:
    accessLogFile: /dev/stdout
EOF
```

* Install the manifest

```
istioctl install --filename ingress-gateways-k8s.yaml
```
> Return
```
This will install the Istio 1.15.0 default profile with ["Istio core" "Istiod" "Ingress gateways"] components into the cluster. Proceed? (y/N) y
✔ Istio core installed                                                                              
✔ Istiod installed                                                                                  
✔ Ingress gateways installed                                                                        
✔ Installation complete                                                                             Making this installation the default for injection and validation.

Thank you for installing Istio 1.15.  Please take a few minutes to tell us about your install/upgrade experience!  https://forms.gle/SWHFBmwJspusK1hv6
```

- [ ] [Check what’s installed](https://istio.io/latest/docs/setup/install/istioctl/#check-what-s-installed)

```
kubectl -n istio-system get deploy
```
> Return
```
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
istio-ingressgateway   1/1     1            1           80s
istiod                 1/1     1            1           87s
```


- [ ] [Customize Kubernetes settings](https://istio.io/latest/docs/setup/additional-setup/customize-installation/#customize-kubernetes-settings)

* Before

```
istioctl profile dump --config-path components.ingressGateways
```
> Return
```
- enabled: true
  name: istio-ingressgateway
```

```
istioctl profile dump --config-path values.gateways.istio-ingressgateway
```
> Return
```
autoscaleEnabled: true
env: {}
name: istio-ingressgateway
secretVolumes:
- mountPath: /etc/istio/ingressgateway-certs
  name: ingressgateway-certs
  secretName: istio-ingressgateway-certs
- mountPath: /etc/istio/ingressgateway-ca-certs
  name: ingressgateway-ca-certs
  secretName: istio-ingressgateway-ca-certs
type: LoadBalancer
```

## :a: Register NLB (Network Load Balancer)

- [ ] Check the `ISTIO` Service Gateway

Port Scheme `PORT:NodePort/Protocol` - `15021:32542/TCP`

```
kubectl get svc -n istio-system istio-ingressgateway
```
> Outputs :
```
NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP                                                                        PORT(S)                                      AGE
istio-ingressgateway   LoadBalancer   100.64.165.217   ab37a(...).elb.ca-central-1.amazonaws.com   15021:30137/TCP,80:30371/TCP,443:30744/TCP   72s
```

- [ ] Retrieve ELB dns entry

```
kubectl get svc istio-ingressgateway \
    --namespace istio-system \
    --output jsonpath="{.status.loadBalancer.ingress[0].hostname}"; echo
```
> Return
```
ab37a36260cbe43a5816f4616a99f12e-75bc995fb8bd0c15.elb.ca-central-1.amazonaws.com
```

## :b: On `AWS`

- [ ] Add entry to [`Route53`](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/routing-to-elb-load-balancer.html)


[AWS: Target groups for your Application Load Balancers](https://docs.aws.amazon.com/elasticloadbalancing/latest/application/load-balancer-target-groups.html)


:round_pushpin: A LoadBalancer

- [ ] listens to TCP ports
- [ ] attaches listeners to actions

<img src=images/AWS_NLB_Listeners.png width="488" height="252" > </img>

```
aws elbv2 describe-load-balancers \
--load-balancer-arns arn:aws:elasticloadbalancing:ca-central-1:159174616622:loadbalancer/net/ab37a36260cbe43a5816f4616a99f12e/75bc995fb8bd0c15 \
| jq '.LoadBalancers[]'        
```
> Outputs :
```json
{
  "LoadBalancerArn": "arn:aws:elasticloadbalancing:ca-central-1:159174616622:loadbalancer/net/ab37a36260cbe43a5816f4616a99f12e/75bc995fb8bd0c15",
  "DNSName": "ab37a36260cbe43a5816f4616a99f12e-75bc995fb8bd0c15.elb.ca-central-1.amazonaws.com",
  "CanonicalHostedZoneId": "Z2EPGBW3API2WT",
  "CreatedTime": "2023-03-23T21:07:31.097000+00:00",
  "LoadBalancerName": "ab37a36260cbe43a5816f4616a99f12e",
  "Scheme": "internet-facing",
  "VpcId": "vpc-0dfd36bff24a46142",
  "State": {
    "Code": "active"
  },
  "Type": "network",
  "AvailabilityZones": [
    {
      "ZoneName": "ca-central-1a",
      "SubnetId": "subnet-0ec9b271bd20677b4",
      "LoadBalancerAddresses": []
    },
    {
      "ZoneName": "ca-central-1b",
      "SubnetId": "subnet-08e8caf57cba4066a",
      "LoadBalancerAddresses": []
    }
  ],
  "IpAddressType": "ipv4"
}
```


:round_pushpin: A Target Group

- [ ] is a listener's action
- [ ] has multiple EC2 instances attached
- [ ] forwards traffic to instances specific ports (i.e. NodePorts)

<img src=images/AWS_NLB_istio_targets.png width="555" height="327" > </img>

:label: `NLB` and `Target Groups` can be defined by `Tags`

<img src=images/AWS_NLB.png width="542" height="213" > </img>
<img src=images/AWS_TargetGroups.png width="548" height="322" > </img>

## :x: Uninstall

[:point_right: ciao](uninstall)
