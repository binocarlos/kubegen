kind = "kubegen.k8s.io/Module.v1alpha2"

namespace = "kube-system"

deployment "weave-flux-agent" {
  labels {
    app = "weave-flux"
    name = "weave-flux-agent"
    weave-cloud-component = "flux"
    weave-flux-component = "agent"
  }

  replicas = 1

  container "agent" {
    image = "quay.io/weaveworks/fluxd:0.1.0"
    image_pull_policy = "IfNotPresent"
    args = [{
      kubegen.String.Join = [
        "--token=",
        {
          kubegen.String.Lookup = "service_token"
        },
      ]
    }]
  }
}

service "weave-flux-agent" {
  labels {
    app = "weave-flux"
    name = "weave-flux-agent"
    weave-cloud-component = "flux"
    weave-flux-component = "agent"
  }
}
