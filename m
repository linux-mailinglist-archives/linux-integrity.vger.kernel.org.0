Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06B92C7F94
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 09:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgK3IRB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 03:17:01 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:37791 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgK3IQ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 03:16:58 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7664B9DC;
        Mon, 30 Nov 2020 03:16:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 30 Nov 2020 03:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=UZt3jBS1V7/eUWPiR5/xHK18WsO
        MuArjHheUEpbXOhg=; b=jrAOk1G1jSED3i1x6WOz17Ux6gGgU71pCodct7jEH2/
        ZnAe9ygZPuuDHsss1oXvGiTEJ7J/MuuDA077iZONIO/ILtoGsY7bzvQPRIpeh7Zc
        95jxNAbtImv4sZDLTDR71FWZx24CciJScGG/RipiRLsfhgN1jBDWnTWVuUln6/Gm
        9fVUB/LnBp9rBUOIvMr4sR9mV6lnF/vTdtZKcd/GOOOlpjTLd3AHVzl0dlveEKVw
        nrsA5WPu+5VIOS10VXYijCZiJv/X01o99pnt2w/gAx40ND9sMuxesqmEiifyCVUD
        YZwzzrLLVAWVyPOeqBeEei6187omtz5/hvo5WXLe7Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=UZt3jB
        S1V7/eUWPiR5/xHK18WsOMuArjHheUEpbXOhg=; b=TVzQQP83T0oz6al6kyfPmR
        T1BMUeCXSXmFX+DsMyGEswe/ZKVP3cRQcfdgSnJvf3gOMUjeomLWCNHUCI69TO8z
        PF4vMvvYQKK0ZD8HJ/yPhDRGd+lG1EKkNob9URN44Lohrxm5HVRdGOO6rAX0mbl9
        H9aSrCX8HwZHZCy4uDH9Fm4pY86yXFgW0u7WO+G0qwUlRE5OW5s8D/QyAQXNuaqW
        5CdmnewODa5fzDIb/n2FuVUmBx3SPEgzzQrRnWmuI2ACvxxRY9F3xwMUBlqV6GzX
        mS9PHuzTYNm4pjt/e02UI+eFZJq3WcPkLMUS9bNY+oEFX9UF7i6LxWb5TKryMUJg
        ==
X-ME-Sender: <xms:S6rEX5KSZPVeGfKQo4xM6Svl39lFqZAT8VFziYUtfYP8pTv5BkkxIg>
    <xme:S6rEX1KwD9oB5EkXGg_7FMaKARZqXDLtMIdEZeHFnI21kZ9whbz9d6FP5bqOkc7ly
    A0J3f81K9FSkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudehledgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepveeuhe
    ejgfffgfeivddukedvkedtleelleeghfeljeeiueeggeevueduudekvdetnecukfhppeek
    fedrkeeirdejgedrieegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhm
X-ME-Proxy: <xmx:S6rEXxsXEJAFOB1kdHRHNjgoUfoHwMaLab0PBTtRCIwnt36k0Ru_VQ>
    <xmx:S6rEX6aEY8crjA3vH2-zS0sc3WPbSVJx9sFwU4ASJfVHyINQrsU6YA>
    <xmx:S6rEXwZj2Md3TUZ43esjfgB6RrjVEk0byCM189NR2A-4N1VQiQjCZQ>
    <xmx:TKrEX_mKDu-iCzOTtUGVE3QhFTdbarFyt1hyWkS3MXG5ikwLH1dxXA>
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        by mail.messagingengine.com (Postfix) with ESMTPA id 682BF3064AAE;
        Mon, 30 Nov 2020 03:16:11 -0500 (EST)
Date:   Mon, 30 Nov 2020 09:17:16 +0100
From:   Greg KH <greg@kroah.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-api@vger.kernel.org
Subject: Re: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
Message-ID: <X8SqjCOJNzL/aZrC@kroah.com>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
 <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 29, 2020 at 02:30:22PM -0800, James Bottomley wrote:
> Create sysfs per hash groups with 24 PCR files in them one group,
> named pcr-<hash>, for each agile hash of the TPM.  The files are
> plugged in to a PCR read function which is TPM version agnostic, so
> this works also for TPM 1.2 but the hash is only sha1 in that case.
> 
> Note: the macros used to create the hashes emit spurious checkpatch
> warnings.  Do not try to "fix" them as checkpatch recommends, otherwise
> they'll break.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Tested-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> 
> ---
> 
> v2: fix TPM 1.2 legacy links failure
> v3: fix warn on and add note to tpm_algorithms
> v4: reword commit and add tested-by
> ---
>  drivers/char/tpm/tpm-sysfs.c | 178 +++++++++++++++++++++++++++++++++++
>  include/linux/tpm.h          |   9 +-
>  2 files changed, 186 insertions(+), 1 deletion(-)

No Documentation/ABI/ entry for new sysfs files?

:(

