Return-Path: <linux-integrity+bounces-78-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 216CC7EEE5A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Nov 2023 10:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE50FB20A88
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Nov 2023 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEADDF5C;
	Fri, 17 Nov 2023 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D87B7;
	Fri, 17 Nov 2023 01:20:48 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r3v0v-000aCz-Kl; Fri, 17 Nov 2023 17:19:50 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Nov 2023 17:19:57 +0800
Date: Fri, 17 Nov 2023 17:19:57 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: David Gstir <david@sigma-star.at>
Cc: Mimi Zohar <zohar@linux.ibm.com>, James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Shawn Guo <shawnguo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>, Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v4 1/5] crypto: mxs-dcp: Add support for hardware-bound
 keys
Message-ID: <ZVcwPUEbu3Frp61X@gondor.apana.org.au>
References: <20231024162024.51260-1-david@sigma-star.at>
 <20231024162024.51260-2-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024162024.51260-2-david@sigma-star.at>

On Tue, Oct 24, 2023 at 06:20:15PM +0200, David Gstir wrote:
> DCP is capable of performing AES with two hardware-bound keys:
> 
> - The one-time programmable (OTP) key which is burnt via on-chip fuses
> - The unique key (UK) which is derived from the OTP key
> 
> In addition to the two hardware-bound keys, DCP also supports
> storing keys in 4 dedicated key slots within its secure memory area
> (internal SRAM).
> 
> These keys are not stored in main memory and are therefore
> not directly accessible by the operating system. To use them
> for AES operations, a one-byte key reference has to supplied
> with the DCP operation descriptor in the control register.
> 
> This adds support for using any of these 6 keys through the crypto API
> via their key reference after they have been set up. The main purpose
> is to add support for DCP-backed trusted keys. Other use cases are
> possible too (see similar existing paes implementations), but these
> should carefully be evaluated as e.g. enabling AF_ALG will give
> userspace full access to use keys. In scenarios with untrustworthy
> userspace, this will enable en-/decryption oracles.
> 
> Co-developed-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> Signed-off-by: David Gstir <david@sigma-star.at>
> ---
>  drivers/crypto/mxs-dcp.c | 104 ++++++++++++++++++++++++++++++++++-----
>  include/soc/fsl/dcp.h    |  17 +++++++
>  2 files changed, 110 insertions(+), 11 deletions(-)
>  create mode 100644 include/soc/fsl/dcp.h

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

