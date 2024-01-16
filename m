Return-Path: <linux-integrity+bounces-816-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C58B382F154
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 16:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C1D31F21995
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 15:21:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FC31C287;
	Tue, 16 Jan 2024 15:21:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D251BF58
	for <linux-integrity@vger.kernel.org>; Tue, 16 Jan 2024 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPlD8-0000tu-OV; Tue, 16 Jan 2024 16:18:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPlD0-000Gxt-VX; Tue, 16 Jan 2024 16:18:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rPlD0-0011AW-2X;
	Tue, 16 Jan 2024 16:18:34 +0100
Date: Tue, 16 Jan 2024 16:18:34 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	dri-devel@lists.freedesktop.org, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Ronald Wahl <ronald.wahl@raritan.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	libertas-dev@lists.infradead.org, Javier Martinez Canillas <javierm@redhat.com>, 
	Alex Elder <elder@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	kernel@pengutronix.de, linux-media@vger.kernel.org, linux-wpan@vger.kernel.org, 
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>, linux-doc@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>, 
	Max Filippov <jcmvbkbc@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	James Clark <james.clark@arm.com>, Guenter Roeck <groeck@chromium.org>, 
	Dario Binacchi <dario.binacchi@amarulasolutions.com>, chrome-platform@lists.linux.dev, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Viresh Kumar <vireshk@kernel.org>, Helge Deller <deller@gmx.de>, Wu Hao <hao.wu@intel.com>, 
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>, Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
	linux-arm-msm@vger.kernel.org, greybus-dev@lists.linaro.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@amd.com>, 
	linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	"David S. Miller" <davem@davemloft.net>, Jarkko Sakkinen <jarkko@kernel.org>, 
	linux-integrity@vger.kernel.org, Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Herve Codina <herve.codina@bootlin.com>, linux-iio@vger.kernel.org, Tom Rix <trix@redhat.com>, 
	linux-fpga@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-mtd@lists.infradead.org, 
	Sam Ravnborg <sam@ravnborg.org>, Rob Herring <robh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	linux-staging@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-input@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Yang Yingliang <yangyingliang@huawei.com>, Moritz Fischer <mdf@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Benson Leung <bleung@chromium.org>, 
	Rayyan Ansari <rayyan@ansari.sh>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-mmc@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Martin Tuma <martin.tuma@digiteqautomotive.com>, Xu Yilun <yilun.xu@intel.com>, 
	Alexander Aring <alex.aring@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Sergey Kozlov <serjk@netup.ru>, 
	Richard Weinberger <richard@nod.at>, Jason Gunthorpe <jgg@ziepe.ca>, Jakub Kicinski <kuba@kernel.org>, 
	Kalle Valo <kvalo@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Rui Miguel Silva <rmfrfs@gmail.com>, linux-mediatek@lists.infradead.org, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 00/33] spi: get rid of some legacy macros
Message-ID: <l4azekfj7hduzi4wcyphispst46fi3m5ams65nzer2ai6upoxw@3p2uki626ytt>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <3404c9af-6c11-45d7-9ba4-a120e21e407e@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ojpgqs276usvjple"
Content-Disposition: inline
In-Reply-To: <3404c9af-6c11-45d7-9ba4-a120e21e407e@sirena.org.uk>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org


--ojpgqs276usvjple
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Mark,

On Tue, Jan 16, 2024 at 02:40:39PM +0000, Mark Brown wrote:
> On Mon, Jan 15, 2024 at 09:12:46PM +0100, Uwe Kleine-K=F6nig wrote:
>=20
> > In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> > some functions were renamed. Further some compat defines were introduced
> > to map the old names to the new ones.
>=20
> > Patch #18 and #19 touch the same driver, otherwise the patches #1 - #31
> > are pairwise independent and could be applied by their respective
> > maintainers. The alternative is to let all patches go via the spi tree.
> > Mark, what's your preference here?
>=20
> I don't have a strong preference here, I'm happy to take all the patches
> if the maintainers for the other subsystem are OK with that - ideally
> I'd apply things at -rc1 but the timeline is a bit tight there.  I think
> my plan here unless anyone objects (or I notice something myself) will
> be to queue things at -rc3, please shout if that doesn't seem
> reasonable.

=46rom my side there is no rush, we lived with these defines since
4.13-rc1. Applying them during the next merge window is fine for me.

Anyhow, I intend to resend the series for the feedback I received after
-rc1. Up to you when you want to apply it. Watching out for offending
patches using lore shouldn't be a big thing and I can do that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ojpgqs276usvjple
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWmnkkACgkQj4D7WH0S
/k7Jlgf/bxg8PBfYKKX7PvDPgT3ZVpLLtWReyLQDBjEkSddRCSKzwPE5dQsE6TGF
pkpgz7Za7CnFfHKtW25alERgnrqA9inDitGvBoBIVgSHPf6GJsGOPVLhziEMU9t1
tBlCUkInYGMvS/Gn5tOoSjNLmapgV8tiNzeos6MHWZzdKpWIzj6SBNH72Bof8kUq
R287GggNJ2PLZa24vL2Pct4BZIfpbD+n1o6O62edEmpGe17xuDkSNfjirG7MojjX
vAtAlEpsLidT0eabHr4XkgyBSQZLwlh1OdReMiXhtK5GM3Oh9R4Y2XVhUq83hKSl
5zzsBEXwEe1w3pKgGJnCD1jxAAcJ9A==
=Sz6E
-----END PGP SIGNATURE-----

--ojpgqs276usvjple--

