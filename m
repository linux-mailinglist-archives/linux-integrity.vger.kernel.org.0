Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8B53C81A0
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238827AbhGNJfS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 05:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbhGNJfQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 05:35:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C264CC06175F
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jul 2021 02:32:24 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m3bFY-0008WH-W8; Wed, 14 Jul 2021 11:32:17 +0200
Subject: Re: [PATCH 3/3] doc: trusted-encrypted: add DCP as new trust source
To:     Richard Weinberger <richard@nod.at>, keyrings@vger.kernel.org
Cc:     David Gstir <david@sigma-star.at>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Fabio Estevam <festevam@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Bottomley <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <20210614201620.30451-1-richard@nod.at>
 <20210614201620.30451-4-richard@nod.at>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <b420c8a7-e6d0-88ac-1215-5ac53487fb4e@pengutronix.de>
Date:   Wed, 14 Jul 2021 11:32:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614201620.30451-4-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Richard,
Hello David,

On 14.06.21 22:16, Richard Weinberger wrote:
> From: David Gstir <david@sigma-star.at>
> 
> Update the documentation for trusted and encrypted KEYS with DCP as new
> trust source:
> 
> - Describe security properties of DCP trust source
> - Describe key usage
> - Document blob format
> 
> Cc: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: David Howells <dhowells@redhat.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: James Bottomley <jejb@linux.ibm.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: keyrings@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Co-developed-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: David Gstir <david@sigma-star.at>
> ---
>  .../security/keys/trusted-encrypted.rst       | 84 ++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 80d5a5af62a1..e8413122e4bc 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -35,6 +35,11 @@ safe.
>           Rooted to Hardware Unique Key (HUK) which is generally burnt in on-chip
>           fuses and is accessible to TEE only.
>  
> +     (3) DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs)
> +
> +         Rooted to a one-time programmable key (OTP) that is generally burnt in
> +         the on-chip fuses and is accessbile to the DCP encryption engine only.

s/accessbile/accessible/ . In the code you differentiate between UNIQUE and OTP.
Here you use OTP to mean both. Perhaps explicitly mention this?

> +
>    *  Execution isolation
>  
>       (1) TPM
> @@ -46,6 +51,12 @@ safe.
>           Customizable set of operations running in isolated execution
>           environment verified via Secure/Trusted boot process.
>  
> +     (3) DCP
> +
> +         Fixed set of cryptographic operations running in isolated execution
> +         environment. Only basic blob key encryption is executed there.
> +         The actual key sealing/unsealing is done on main processor/kernel space.
> +
>    * Optional binding to platform integrity state
>  
>       (1) TPM
> @@ -63,6 +74,11 @@ safe.
>           Relies on Secure/Trusted boot process for platform integrity. It can
>           be extended with TEE based measured boot process.
>  
> +     (3) DCP
> +
> +         Relies on Secure/Trusted boot process (called HAB by vendor) for
> +         platform integrity.
> +
>    *  Interfaces and APIs
>  
>       (1) TPM
> @@ -74,10 +90,14 @@ safe.
>           TEEs have well-documented, standardized client interface and APIs. For
>           more details refer to ``Documentation/staging/tee.rst``.
>  
> +     (3) DCP
> +
> +         Vendor-specific API that is implemented as part of the DCP crypto driver in
> +         ``drivers/crypto/mxs-dcp.c``.
>  
>    *  Threat model
>  
> -     The strength and appropriateness of a particular TPM or TEE for a given
> +     The strength and appropriateness of a particular TPM, TEE or DCP for a given
>       purpose must be assessed when using them to protect security-relevant data.
>  
>  
> @@ -103,6 +123,14 @@ access control policy within the trust source.
>       from platform specific hardware RNG or a software based Fortuna CSPRNG
>       which can be seeded via multiple entropy sources.
>  
> +  * DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs)
> +
> +     The DCP hardware device itself does not provide a dedicated RNG interface,
> +     so the kernel default RNG is used. SoCs with DCP like the i.MX6ULL do have
> +     a dedicated hardware RNG that is independent from DCP which can be enabled
> +     to back the kernel RNG.
> +
> +
>  Encrypted Keys
>  --------------
>  
> @@ -188,6 +216,19 @@ Usage::
>  specific to TEE device implementation.  The key length for new keys is always
>  in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>  
> +Trusted Keys usage: DCP
> +-----------------------
> +
> +Usage::
> +
> +    keyctl add trusted name "new keylen" ring
> +    keyctl add trusted name "load hex_blob" ring
> +    keyctl print keyid
> +
> +"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
> +specific to this DCP key-blob implementation.  The key length for new keys is
> +always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> +
>  Encrypted Keys usage
>  --------------------
>  
> @@ -370,3 +411,44 @@ string length.
>  privkey is the binary representation of TPM2B_PUBLIC excluding the
>  initial TPM2B header which can be reconstructed from the ASN.1 octed
>  string length.
> +
> +DCP Blob Format
> +---------------
> +
> +The Data Co-Processor (DCP) provides hardware-bound AES keys using its
> +AES encryption engine only. It does not provide direct key sealing/unsealing.
> +To make DCP hardware encryption keys usable as trust source, we define
> +our own custom format that uses a hardware-bound key to secure the sealing
> +key stored in the key blob.
> +
> +Whenever a new tusted key using DCP is generated, we generate a random 128-bit

s/tusted/trusted/

> +blob encryption key (BEK) and 128-bit nonce. The BEK and nonce are used to
> +encrypt the trusted key payload using AES-128-GCM.
> +
> +The BEK itself is encrypted using the hardware-bound key using the DCP's AES
> +encryption engine with AES-128-ECB. The encrypted BEK, generated nonce,
> +BEK-encrypted payload and authentication tag make up the blob format together
> +with a version number, payload length and authentication tag::
> +
> +    /*
> +     * struct dcp_blob_fmt - DCP BLOB format.
> +     *
> +     * @fmt_version: Format version, currently being %1
> +     * @blob_key: Random AES 128 key which is used to encrypt @payload,
> +     *            @blob_key itself is encrypted with OTP or UNIQUE device key in
> +     *            AES-128-ECB mode by DCP.
> +     * @nonce: Random nonce used for @payload encryption.
> +     * @payload_len: Length of the plain text @payload.
> +     * @payload: The payload itself, encrypted using AES-128-GCM and @blob_key,
> +     *           GCM auth tag of size AES_BLOCK_SIZE is attached at the end of it.
> +     *
> +     * The total size of a DCP BLOB is sizeof(struct dcp_blob_fmt) + @payload_len +
> +     * AES_BLOCK_SIZE.
> +     */
> +    struct dcp_blob_fmt {
> +            __u8 fmt_version;
> +            __u8 blob_key[AES_KEYSIZE_128];
> +            __u8 nonce[AES_KEYSIZE_128];
> +            __le32 payload_len;
> +            __u8 payload[0];

[] ?

> +    } __packed;
> 

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
