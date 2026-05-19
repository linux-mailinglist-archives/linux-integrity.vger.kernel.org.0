Return-Path: <linux-integrity+bounces-9603-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJWdA0NpDGo8hQUAu9opvQ
	(envelope-from <linux-integrity+bounces-9603-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 15:44:35 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9365A57FEA9
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 15:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3CD9307403A
	for <lists+linux-integrity@lfdr.de>; Tue, 19 May 2026 13:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBBA348C6F;
	Tue, 19 May 2026 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPbjvKpv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBCF23392B
	for <linux-integrity@vger.kernel.org>; Tue, 19 May 2026 13:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197931; cv=pass; b=UcveAy2NJlHcmZAJBbtehkIKOfXE8AN5QhcjfgeiRa/aAA7ExE6ZL3LGnKXtYwjhh97aJQnveuva6v0AULx4Ym9Etfmm8Qsgb3ewTfjtIWpx+J8460HFiVGFB9vlrwnKC9YqP4+sHGw7VMAt6JWIS4XvnzUBImvHwEEEmWTwbc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197931; c=relaxed/simple;
	bh=KP7zUHOrkzgdt1cRpKbtyeNbsXf5dD6XKZ2LFxmQcjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i4kff36mEeamC6/RK4+QU09Z3yTZdkjxXc39ILB7r0Fsi2Xl3ND6nfLgAQoHOPnIQq0qkhW61dE9XR3pgoMlcE+Ic9+sVM4AxrFH3CIDIkeZBZgipdznPIH7nWcnurLwP1Dx2jVv0ds69cSkZvGai1xzlj9yMYAl0X1RDa7l3v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPbjvKpv; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f0ad52830cso4293692eec.1
        for <linux-integrity@vger.kernel.org>; Tue, 19 May 2026 06:38:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779197929; cv=none;
        d=google.com; s=arc-20240605;
        b=EgZCnV1hvuXu44/sYo34dgMosdAj61tVqQmShELJNIq5NIFJWPaAxcnlMgsx/PcCB9
         OCxpk2u+sSKyr5B75TZnqhhWodb8f4UK9Dl9VA5NkaWAG243jABOZ1cxDGHLNU8Jgo2T
         oqdrp17vbcQb+3bY9611pjSzubMqna9UlwIamQbhFknoQIZC4eIpKfanlBFepXtblWvn
         NtY+UfQVKvU4dWhNpEGZ4RQbuvvH8kaox5LSvGThKFZqzVX2euUyfRytWlblxNpeS6SI
         etoIZ6oP3pRc7OJ+lWFLfdKQK0Mfq/yN0M0O1QeS3SMmUReaEmsAIYFqlh+x/lLrntzv
         ruJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4rLi9EF1nJ5zuh+5Rs48RasaCD3EpgpMag9kYOR3Lik=;
        fh=WMnc0LDduRwwotuldhxlTjqrjO0Znb2Kwonk9UPjtDc=;
        b=W2+Un/HXT4SN4N0zU5sdKVI8MiaMnHz0SF1/gIHIhS4HhE1giZCfN712deE7O2IOMD
         A/hvG5qfMYLXqo3p8CETKXCI3YbhKfCO7pbhoguuqJ7t2J6LPHziPtiLkglmp4l+5c0y
         JA7wMQ1EbPqS4Uz9suuHnvmiW4FHYcTH0FDBO997UveLjjh4xD5TwLoOeDhM2j4cWYMB
         XVdXP9p/K8I+RWKCma9p+mrs2lQ0eMAcYsvzRFmi5uYJQgS5xwJHECDKcAdEVszN3Cze
         8ZSqI8wg4JYdtHZBlIgxnkZfr7eZ23vu7Zbq3IBgHSadU0LDOJ9M7F5EkrKhB7FRi9An
         b7pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779197929; x=1779802729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rLi9EF1nJ5zuh+5Rs48RasaCD3EpgpMag9kYOR3Lik=;
        b=OPbjvKpvK+OOsLnQTyTbj/EEwx/Tqt3Q1Bf7N2TZJ28bLrcnJtva4CFBMJtMzij0mD
         JnqsJqYu1ilCuw1SrjoDXnDPeRfxULJdIQMhUDjM4UlAQ88XlEoM5xRpCHNq4OMV3NSC
         E5FuXpSSOn1SsQXfUTKYryw/aLxox2YWCykG3akE5P9U5/Bp7gY73o9JsHbsh40lB6A4
         jioI+ZxrGzU8sfge6iPPMUedq9g7VFqrB/8XpoWeIiN0pB4+WVzThesgkqeYJsIRMUlc
         sxg++URubx45Tn6+TM3VhE/WCdKpwCIGj5Pk4OpgbRoURB98A0Dklu+Ui17iluY5rOMo
         x+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779197929; x=1779802729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4rLi9EF1nJ5zuh+5Rs48RasaCD3EpgpMag9kYOR3Lik=;
        b=keX96fJYOR5iAUcLmQOMXLfj+7WMn9kzhwv/JZJygvKIKtwL4N/pSFYtpBji+KQNRk
         nuJgWPS46i9dPvGIkqqGuKvVViZbS6WfhN0Yj1FzwaQwlgpWCUxE8wEAvT3CpMgTJyf5
         uuOOuIFX5MEH8ZpdVWcumPBxI5wY4+mWSNLLWMsxNS3tGlRFAMOpDKWgOhFQqF1pKKzr
         mMd+u3wlp7BHtPnshShbQIUH0GQuQyKvlFZqsMScuAKzfW8MgtNWT1TilXF8sg4e++oB
         LerIb7UFOWawpbIt0WRTBOrHQBVQT87KpTguDDyx7pojEqp26UTkkyPYGh5Z6tjRcvw+
         G8Qg==
X-Gm-Message-State: AOJu0Yzqzn+RiQ6LskbsXAlPQdzMdBxYRFcYhDUEBMm8fFBs5PpCsuPH
	REwA1oYkP2Ukb8RpN7u8jj86QxOUgdPiPvx08hj5xk54OzQKn8yw75PI8WmOyfxTio9TO3sNY0R
	4GdItPP2HrZK1aieZ7TJl623TNBeAI93eZhxtfJ1B2A==
X-Gm-Gg: Acq92OEuSnes9iMsXkH5G6CH7U3Y0cp9nPcrPlfto6rwxoPeykQhLNDC2CqOlopQU+7
	UCHDVCr0DeEZb7jxALGelxD21tYzkw0dEUJfAPGoYK3PZXlOHIFEwBR7cT1CLA0JMsFB9rp8TOP
	3QK8njkyHW5MmZKU6plOTyrUo7dXnvclAJIt0v/SFcRNN9fNbuIIMjpOavh2HjqSRQAnWeDY75J
	laWTDRn2h3fWXbKA3T3OldQRTXdj1FX0hzC+O8eyCJyOoHaFSiNFpCpkpufvdKJ+yvLO2pxdemQ
	bqJ1uRoA85Oq1bJC
X-Received: by 2002:a05:7300:a146:b0:2ea:ed7c:8064 with SMTP id
 5a478bee46e88-3039816dc0fmr7981877eec.3.1779197928558; Tue, 19 May 2026
 06:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519060926.103727-1-jbroadus@gmail.com>
In-Reply-To: <20260519060926.103727-1-jbroadus@gmail.com>
From: Jim Broadus <jbroadus@gmail.com>
Date: Tue, 19 May 2026 06:38:37 -0700
X-Gm-Features: AVHnY4LT_jG2no69Sj6hc2qtUbtjHtBegcw9-dznFgFDKMTe2apHJoCmGtMe5Bo
Message-ID: <CAKgEEwsXD4_Bks1J=irU8c2UbFY4fX9g3H6On3hBiV+DckGQxA@mail.gmail.com>
Subject: Re: [PATCH] tpm: tpm_tis: Add optional delay after relinquish
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Cc: peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9603-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,ziepe.ca];
	FREEMAIL_FROM(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbroadus@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,trustedcomputinggroup.org:url]
X-Rspamd-Queue-Id: 9365A57FEA9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I realize the delay should be moved to __tpm_tis_relinquish_locality.
I'll change that in a v2 patch.


On Mon, May 18, 2026 at 11:09=E2=80=AFPM Jim Broadus <jbroadus@gmail.com> w=
rote:
>
> Some TPMs fail to grant locality when requested immediately after being
> relinquished. In this case, the TPM_ACCESS_REQUEST_USE bit of the
> TPM_ACCESS register is cleared immediately without setting
> TPM_ACCESS_ACTIVE_LOCALITY.
>
> This issue can be seen at boot since tpm_chip_start, called right
> after locality is relinquished, fails. This causes the probe to fail:
>
> tpm_tis MSFT0101:00: probe with driver tpm_tis failed with error -1
>
> This occurs on some older Dell Latitudes and maybe others. To work
> around this, add a "settle" boolean param to tpm_tis. When this is
> enabled, a delay is added after locality is relinquished.
>
> Signed-off-by: Jim Broadus <jbroadus@gmail.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
>  drivers/char/tpm/tpm_tis.c                      | 7 +++++++
>  drivers/char/tpm/tpm_tis_core.c                 | 3 +++
>  drivers/char/tpm/tpm_tis_core.h                 | 1 +
>  4 files changed, 18 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 4d0f545fb3ec..5b7111033fbb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7651,6 +7651,13 @@ Kernel parameters
>                         defined by Trusted Computing Group (TCG) see
>                         https://trustedcomputinggroup.org/resource/pc-cli=
ent-platform-tpm-profile-ptp-specification/
>
> +       tpm_tis.settle=3D [HW,TPM]
> +                       Format: <bool>
> +                       When enabled, this adds a delay after locality is
> +                       relinquished. Some TPMs will fail to grant locali=
ty if
> +                       requested immediately after being relinquished. T=
his
> +                       causes the probe to fail.
> +
>         tp_printk       [FTRACE]
>                         Have the tracepoints sent to printk as well as th=
e
>                         tracing ring buffer. This is useful for early boo=
t up
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 9aa230a63616..8ac0ea78570e 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -101,6 +101,10 @@ module_param(force, bool, 0444);
>  MODULE_PARM_DESC(force, "Force device probe rather than using ACPI entry=
");
>  #endif
>
> +static bool settle;
> +module_param(settle, bool, 0444);
> +MODULE_PARM_DESC(settle, "Add settle time after relinquish");
> +
>  #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
>  static int has_hid(struct acpi_device *dev, const char *hid)
>  {
> @@ -242,6 +246,9 @@ static int tpm_tis_init(struct device *dev, struct tp=
m_info *tpm_info)
>         if (itpm || is_itpm(ACPI_COMPANION(dev)))
>                 set_bit(TPM_TIS_ITPM_WORKAROUND, &phy->priv.flags);
>
> +       if (settle)
> +               set_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &phy->priv.flags=
);
> +
>         return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
>                                  ACPI_HANDLE(dev));
>  }
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 21d79ad3b164..68be26fa5817 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -184,6 +184,9 @@ static int tpm_tis_relinquish_locality(struct tpm_chi=
p *chip, int l)
>                 __tpm_tis_relinquish_locality(priv, l);
>         mutex_unlock(&priv->locality_count_mutex);
>
> +       if (test_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &priv->flags))
> +               tpm_msleep(TPM_TIMEOUT);
> +
>         return 0;
>  }
>
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_c=
ore.h
> index 6c3aa480396b..413cac5e0f31 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -90,6 +90,7 @@ enum tpm_tis_flags {
>         TPM_TIS_DEFAULT_CANCELLATION    =3D 2,
>         TPM_TIS_IRQ_TESTED              =3D 3,
>         TPM_TIS_STATUS_VALID_RETRY      =3D 4,
> +       TPM_TIS_SETTLE_AFTER_RELINQUISH =3D 5,
>  };
>
>  struct tpm_tis_data {
> --
> 2.54.0
>

