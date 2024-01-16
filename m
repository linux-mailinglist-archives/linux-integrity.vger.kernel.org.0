Return-Path: <linux-integrity+bounces-814-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF6682F0A8
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 15:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8D7285D4F
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE871BF2D;
	Tue, 16 Jan 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoW8PYM2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D01BF2A;
	Tue, 16 Jan 2024 14:41:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82385C433F1;
	Tue, 16 Jan 2024 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705416062;
	bh=pi9f5n7aCz4k4GcDtHhDD5lv5OgeZ4ucYdJWw/uz8rU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoW8PYM2MfAuIBhKaoTZlWZwOEH64nrarWgh8smz385NHA2AvWbxhu44TZid6guIO
	 ztdPcokve4KGk/P0r48xP9LXjdlp+nfRggeFVeFp1EKUfQh1HSmalAz393OHzBH8yx
	 HITZr7gQr/eVgLSaMXJ0zK/Hypf/9tgOSbSJiXzjxDaUW1d3OgO9S7G4+/H4mw666+
	 L5PksNx2fvrD/Q9/Cn2uOjt9fv52HRvN58krYPnsggJ/tW1Mam7cV3tInWEBTcjzIV
	 QhTlg/jUO4g8ofnL8rKCTYV2n5vBGWNCAEmw7Luoyo7bgDS5dKI4oEy8rewQcDvB/c
	 CCz+OFltnyGUA==
Date: Tue, 16 Jan 2024 14:40:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-spi@vger.kernel.org,
	kernel@pengutronix.de, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Sergey Kozlov <serjk@netup.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	Rob Herring <robh@kernel.org>, linux-mtd@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev,
	Michal Simek <michal.simek@amd.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, Rui Miguel Silva <rmfrfs@gmail.com>,
	Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
	Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-usb@vger.kernel.org, Helge Deller <deller@gmx.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
	libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 00/33] spi: get rid of some legacy macros
Message-ID: <3404c9af-6c11-45d7-9ba4-a120e21e407e@sirena.org.uk>
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c8yli56mmI+gJGEV"
Content-Disposition: inline
In-Reply-To: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
X-Cookie: Programmers do it bit by bit.


--c8yli56mmI+gJGEV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 09:12:46PM +0100, Uwe Kleine-K=F6nig wrote:

> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions were renamed. Further some compat defines were introduced
> to map the old names to the new ones.

> Patch #18 and #19 touch the same driver, otherwise the patches #1 - #31
> are pairwise independent and could be applied by their respective
> maintainers. The alternative is to let all patches go via the spi tree.
> Mark, what's your preference here?

I don't have a strong preference here, I'm happy to take all the patches
if the maintainers for the other subsystem are OK with that - ideally
I'd apply things at -rc1 but the timeline is a bit tight there.  I think
my plan here unless anyone objects (or I notice something myself) will
be to queue things at -rc3, please shout if that doesn't seem
reasonable.

--c8yli56mmI+gJGEV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWmlVwACgkQJNaLcl1U
h9AImgf/YhrOsj57KBdfXCGkJi2n+rTwU/YN3Vvfy2fP+4gmJoFGfjk1o+luXQwi
q3+RNetq9JicN07DE0eggUdY7EqvLtghmHnQWYraw+gEPT7PwkiFuKZgDEy79tmH
pNpJuEKTeDipvLkXCVMzD0T+NrW2BXshkACyxLpBrh+ewGJpmmgJEH8LEo52dxrk
uLfK3YjSYco5zXw8Dzak8Ea9Hb57dnySjT6aQf8GRXZMjNYAPqMC27Pzd5pWHnD1
am4raQY/1ji5yjiVs38+2RB0EnWlFJyj0VvC9vL5PEhkz0XiW3OTTedLKcxKKoYv
H+d+5ZwIRVx3bl+qcRRzH8EMyJW7pA==
=Umm1
-----END PGP SIGNATURE-----

--c8yli56mmI+gJGEV--

