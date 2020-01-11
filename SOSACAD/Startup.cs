using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(SoSACAD.Startup))]
namespace SoSACAD
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
