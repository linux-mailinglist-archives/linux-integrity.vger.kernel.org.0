Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37EE3F8317
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 23:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfKKWok (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 17:44:40 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46355 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbfKKWok (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 17:44:40 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DB43221FD;
        Mon, 11 Nov 2019 17:44:39 -0500 (EST)
Received: from imap1 ([10.202.2.51])
  by compute2.internal (MEProxy); Mon, 11 Nov 2019 17:44:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fraction.io; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm2; bh=J13gUZT3JbB9LK9MdV8RGp4yB/ukIEC
        qCz4BDFNtC9A=; b=zjW64gRElvzr6BW07230JYvJ3O054IvOmBv+BxHXRc5QC32
        iQYPWCpkcNdSbSVIJj3YmPgTeKx0/dOi5aXpSS+wBZCDC9j8NdNozw0J6HAjsYL9
        fHUCkz8X8ZIGFEdBaEsPDzFBjRg5yZxaMSNHAP4O0pyWP6Wztth3R4FQDRsT55m7
        5FIXU6/yp9uXXeyq/bLhaKVFljBL1gaVHI2FL7I6FYLGMjWGMy8u6inExFwHpACA
        wEswcUghzsE/WblwW5l2N13jeH1+idleuFjcVtwz8Uicb8sIkCDgSL7ABLsf8gHt
        y5NEKoAuvUmp+ZhzSRhkqpi6QBP6G0pj78iIZCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=J13gUZ
        T3JbB9LK9MdV8RGp4yB/ukIECqCz4BDFNtC9A=; b=U0vN7Lw81OH98wm4BFJ7iM
        qjB7KZXTt9WQxDJlhagK5ywp/RrybCcQws3Dw98ohX5cqGQKSHMggBxSKvnoLS3b
        rRe2nNoG/hPBrzQFXyvYHJmXtb0+bIFHn9jHgvgrUWms5T3skIm8t3jwNm1uC7Hp
        giyOSkRZmTOW2Z9r2SyteJGSd8FnWgiIuiEbEJux83iVUvHDAO/H37BwMm3Muf5m
        F8lzl/5pQ32Nbqb29YLwJykHFaCqzcc6ULWEV5dlecNwQYgz1R4Ra0GCb/whFzjn
        Ucld1mO/wjsfSSB3R33J39/tcVXzK0fZRoS/jCd80vRJ9OYWmeqzXXM54x8eKKjg
        ==
X-ME-Sender: <xms:VuTJXTt0JgNRMsfQ6UxFtq-nT4FeS1milW8QyQKuy7s2QRvcpKxBRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedruddvjedgudeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfvehh
    rhhishhtihgrnhcuuehunhguhidfuceotghhrhhishhtihgrnhgsuhhnugihsehfrhgrtg
    htihhonhdrihhoqeenucfrrghrrghmpehmrghilhhfrhhomheptghhrhhishhtihgrnhgs
    uhhnugihsehfrhgrtghtihhonhdrihhonecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:VuTJXaliuzEGTu0zDI5c8w62hmL40JSCiedBWdAaK_WssnLNhvQMoA>
    <xmx:VuTJXdSJatObcRel_Y925mbDpfgDtZA47tgH6A_RcCBUz669qWpMdw>
    <xmx:VuTJXcO8OXTIRo4d9bHY_YSpKTsTcztFA6edB_f8dXAp-vjwKLv0rg>
    <xmx:V-TJXaqVSfjSBDJrE705VZKe_cVp73YE7RgC1QMWao3zK54dpcgZqQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 4D60DC200A5; Mon, 11 Nov 2019 17:44:38 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.7-509-ge3ec61c-fmstable-20191030v1
Mime-Version: 1.0
Message-Id: <f2e12b33-c348-4325-8ef6-747e3a8f5e90@www.fastmail.com>
In-Reply-To: <20191111215714.kw3doe3qf5ps7imk@cantor>
References: <a60dadce-3650-44ce-8785-2f737ab9b993@www.fastmail.com>
 <20191110072611.2k6tjt4geiq2rqol@cantor>
 <20191111215714.kw3doe3qf5ps7imk@cantor>
Date:   Mon, 11 Nov 2019 14:44:18 -0800
From:   "Christian Bundy" <christianbundy@fraction.io>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>,
        "Jarkko Sakkinen" <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: Re: PROBLEM: TPM bug causes suspend to turn off device
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

It worked! Thanks a bunch Jerry, that was a quick resolution.

I'm no longer seeing any errors in dmesg and suspend is working as expected.

(FYI, I'm testing your patch on top of 8005803a2ca0af49f36f6e9329b5ecda3df27347.)

On Mon, Nov 11, 2019, at 13:57, Jerry Snitselaar wrote:
> On Sun Nov 10 19, Jerry Snitselaar wrote:
> >Jarkko, should there be tpm_chip_start/tpm_chip_stop calls around
> >the tpm1_getcap calls in tpm1_get_timeouts?
> >
> 
> Maybe moving the tpm_chip_start called before the irq probe to before
> tpm_get_timeouts:
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c 
> b/drivers/char/tpm/tpm_tis_core.c
> index 270f43acbb77..806acc666696 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -974,13 +974,14 @@ int tpm_tis_core_init(struct device *dev, struct 
> tpm_tis_data *priv, int irq,
>                   * to make sure it works. May as well use that command 
> to set the
>                   * proper timeouts for the driver.
>                   */
> +               tpm_chip_start(chip);
>                  if (tpm_get_timeouts(chip)) {
>                          dev_err(dev, "Could not get TPM timeouts and 
> durations\n");
>                          rc = -ENODEV;
> +                       tpm_chip_stop(chip);
>                          goto out_err;
>                  }
>   
> -               tpm_chip_start(chip);
>                  chip->flags |= TPM_CHIP_FLAG_IRQ;
>                  if (irq) {
>                          tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
> 
>
