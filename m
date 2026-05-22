Return-Path: <linux-integrity+bounces-9633-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM5CG8TxD2o2RwYAu9opvQ
	(envelope-from <linux-integrity+bounces-9633-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 08:03:48 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 179645AF565
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 08:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EADF3012D49
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 06:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A71F12E0;
	Fri, 22 May 2026 06:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m79J9SIe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAF13603DA
	for <linux-integrity@vger.kernel.org>; Fri, 22 May 2026 06:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779429825; cv=pass; b=Y7MrcOz36+SaXdvjmfd94DdFInv/qUHw6csJY70Gp0+x8tRzytDpTuu/wxocHP2qvoaDQPycYSh0WemssvX80yT6c9uCL2rRv0Z03bWRQvaOyNSOcF/hXIe0M9f6EDgLSZVIIA3Zv+dH4ZUwSN6veQ1yQamcUECmTQHmv+5qnZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779429825; c=relaxed/simple;
	bh=HhLz431XC/1SBtKZs6jOZJe1J0Hy0TUDih2j/njNowo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AQwQKOr9lcOfvXDyB3RVflkFH6+6H51PEhOS3joQpFNqB2FiPQEZNhbzTr3xmIS9FEJvQ2SPaPFKPC1zkSjDJqLQmxRxpT4dgs2TJabArBJWgwCxcgWhVDVJGhqGQR0l/DlblACkEneehiBIF+G6fFR55glFI1rDuBKpHFX75AM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m79J9SIe; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso7045316eec.0
        for <linux-integrity@vger.kernel.org>; Thu, 21 May 2026 23:03:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779429823; cv=none;
        d=google.com; s=arc-20240605;
        b=DxOqbVKhe0VlrBumaj2DSoxI3SvscjzFW/s6wXmicS84cK+MSO3WmsDoywVqF3gbg9
         otyDAJS/VIYtViQjFR9uxSrjvd7WAP17a53c6oNTGeD3bMbbPyNGkOL+iWBTO7mbAHiK
         RthapqrqWVJQeBv+rU0Ko3XFVAC+Sq/noKJ/XhZMPbWdPeKgqMMPCbs4JH8qXU8J1ZeJ
         tN9ha5DzxqgGnHYUdIovkTTvXw+tFP4RYFKe/vWeXlXrHpVaq3KFaV3HLoGATwt9bABe
         eezhjy4QG/IV+lVBT90XMkZPpMvrENcQes63ci/dw87USSXpXpgSnftbbGRO1Zwg5eL3
         5WnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dQ6hVnT8+IvfQww+UWuTp0nQS0/uDMuAD01ImXMAqTM=;
        fh=6JWiylxW3WcNtqCp5HQ9K7bHrW7o11OWckxHu2eB5zw=;
        b=GDoYYlAIJPVhHzRl+pdo9Nm7ANMdC3jS9gbQeAAUa78BtoW1L5SOurbNlujnWBA58t
         dxy7IcMpAJg+mlhFq+RdNaju6xZtaT/vs4E3yhwdytakSe99U5SHunv+K9s+j3hid40p
         L1wt3nmIja/1gLwcLs9j6FOEzQe/PrMvCq8UOeLD0K1KZQiMvM88Pp+EOTKWijy2gYX+
         BIVcPnXef/rUHHGKMBak/Uxo/OpiVnCEY1J4Cg/9Knh+Wj+nB/HK1sCpDgg4hoM7y2Kn
         mtnzpD9RNSApI+aMhMYDXqYNWGk0YvyrsnXSKEtJe1BMfJxmKzA38HbDDqRHpykfINXi
         fEvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779429823; x=1780034623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQ6hVnT8+IvfQww+UWuTp0nQS0/uDMuAD01ImXMAqTM=;
        b=m79J9SIeYJVw+fQtfY7IjR5CxEzgTT0XMaFULHPp4eWRK9UX4oCciHJkykyDXx8iTj
         uhlfjH/HOXznWzetoZbEqNoVhVyzBJ+vYkVcQvnGyeN9mJiufKkt9dv4qQ4V4rjJUgCV
         +IC1fWbZEiOqRmGSQD/YF2vxnDniLh0Attw2w2t3bjS9DevywxkRfZ9MU82XQCi+eqK4
         BeQr9ne7R6OZiThcEeAZDYkfdzBfaPLlcQZw0rPlkGA1T5cu9QWisc4YRlqgY5cgglGu
         O0vy98ybuRYcm/ZX4A131awzxC3/oCd4SWVvsW+3XoJad6a2mGzVr2IMre+NM+IteFGX
         Kwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779429823; x=1780034623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dQ6hVnT8+IvfQww+UWuTp0nQS0/uDMuAD01ImXMAqTM=;
        b=FtBZo2d6G5Dgdqrv8AQnfmpaSgzoEyagAjI9+0qMYS9gyBg2LaVmLm4if5J3rsOzDL
         HPHv7gbfOEr/9OKdBz8yHh17CuvFUzcNaIT6F13Kq6WiVSiiLWQuxJuBHHHH6o6r5wy1
         xTGhdumIutWuiWBscWHnAQGw58meaZ3rohh30ZETa2our4Phlt6yYmVPo3KV6KRGNieN
         s9s0kjOPfinFNK4I3lAwsLQ2qaSKmXsTHjsvND6aLfX/PBA4OgP0e/mGx4jF7UfsXm74
         86mJKRMTDc7UxbIhsqKjFRK7Vm3U7M1T9kOk2sm+FR42a/pQfWITbz6VtVd3jIu+qujz
         KwEQ==
X-Gm-Message-State: AOJu0YxvDhn8GR7R/ONlpi2F9argq5WzzeePg/STg+PK8FiW02gcAUJc
	bK3eqjWb8MQ1ANJxedKgjyzX0pVeL+6ccjlvrz8Mfaui5gYZ8IJi0GM7p9v2WgwLFx7p42fkxPq
	SLDTtJvL98OJFIscLTggckYS+6cwbCiI=
X-Gm-Gg: Acq92OFD44gstViMDG91oiZDwbmhT0eGZ7T4xicJxUXKsKMGusJQNO7KQuLYhjWfetQ
	KUAPhVW687TO4jwasovkQ5fLxBIRGsoVeXKVo7XLCSngWXxppcXDKluW8t/Y+GlYUhAi1zfH8Dj
	smTkYlIX6hc0h1zBJqVGTWs3nvz+P9oJ//RsUWfttJyymwQRJKEom3EHwYtwc2tCgGoZPH98+6x
	4Ue03NirmId3fSAq8+QEvMuiSSdYI4iFnctGMHGdm8vz58nV3GJSkyt5X+0oA+M1VjOdDZQ4niv
	S9TLgg==
X-Received: by 2002:a05:7300:a509:b0:2da:2ec2:64e5 with SMTP id
 5a478bee46e88-304491840e6mr1102704eec.18.1779429822576; Thu, 21 May 2026
 23:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519060926.103727-1-jbroadus@gmail.com> <ag-ZuEt4uXnrO8AK@kernel.org>
In-Reply-To: <ag-ZuEt4uXnrO8AK@kernel.org>
From: Jim Broadus <jbroadus@gmail.com>
Date: Thu, 21 May 2026 23:03:29 -0700
X-Gm-Features: AVHnY4LA3QImdAO1-9EbSoxvRtYQWmfgsDIstzlg6YCBI-BFraaiDzGtwN3bdiw
Message-ID: <CAKgEEwswj4in29_hoy_dQQ18+GF=Uwf0LnwS=w7bwZCSW=mwjw@mail.gmail.com>
Subject: Re: [PATCH] tpm: tpm_tis: Add optional delay after relinquish
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9633-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de,ziepe.ca];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jbroadus@gmail.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 179645AF565
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thank you Jarkko. I'll do that.

Jim

On Thu, May 21, 2026 at 4:48=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Mon, May 18, 2026 at 11:09:26PM -0700, Jim Broadus wrote:
> > Some TPMs fail to grant locality when requested immediately after being
> > relinquished. In this case, the TPM_ACCESS_REQUEST_USE bit of the
> > TPM_ACCESS register is cleared immediately without setting
> > TPM_ACCESS_ACTIVE_LOCALITY.
> >
> > This issue can be seen at boot since tpm_chip_start, called right
> > after locality is relinquished, fails. This causes the probe to fail:
> >
> > tpm_tis MSFT0101:00: probe with driver tpm_tis failed with error -1
> >
> > This occurs on some older Dell Latitudes and maybe others. To work
> > around this, add a "settle" boolean param to tpm_tis. When this is
> > enabled, a delay is added after locality is relinquished.
> >
> > Signed-off-by: Jim Broadus <jbroadus@gmail.com>
>
> It would be better idea first to replace priv->manufacturer_id with
> priv->did_vid, and make necessary changes to sites where it is used.
>
> Then in the if-statement compare DID/VID of the device to priv->did_vid
> and apply quirk only if it matches.
>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
> >  drivers/char/tpm/tpm_tis.c                      | 7 +++++++
> >  drivers/char/tpm/tpm_tis_core.c                 | 3 +++
> >  drivers/char/tpm/tpm_tis_core.h                 | 1 +
> >  4 files changed, 18 insertions(+)
> >
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Document=
ation/admin-guide/kernel-parameters.txt
> > index 4d0f545fb3ec..5b7111033fbb 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -7651,6 +7651,13 @@ Kernel parameters
> >                       defined by Trusted Computing Group (TCG) see
> >                       https://trustedcomputinggroup.org/resource/pc-cli=
ent-platform-tpm-profile-ptp-specification/
> >
> > +     tpm_tis.settle=3D [HW,TPM]
> > +                     Format: <bool>
> > +                     When enabled, this adds a delay after locality is
> > +                     relinquished. Some TPMs will fail to grant locali=
ty if
> > +                     requested immediately after being relinquished. T=
his
> > +                     causes the probe to fail.
> > +
> >       tp_printk       [FTRACE]
> >                       Have the tracepoints sent to printk as well as th=
e
> >                       tracing ring buffer. This is useful for early boo=
t up
> > diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> > index 9aa230a63616..8ac0ea78570e 100644
> > --- a/drivers/char/tpm/tpm_tis.c
> > +++ b/drivers/char/tpm/tpm_tis.c
> > @@ -101,6 +101,10 @@ module_param(force, bool, 0444);
> >  MODULE_PARM_DESC(force, "Force device probe rather than using ACPI ent=
ry");
> >  #endif
> >
> > +static bool settle;
> > +module_param(settle, bool, 0444);
> > +MODULE_PARM_DESC(settle, "Add settle time after relinquish");
> > +
> >  #if defined(CONFIG_PNP) && defined(CONFIG_ACPI)
> >  static int has_hid(struct acpi_device *dev, const char *hid)
> >  {
> > @@ -242,6 +246,9 @@ static int tpm_tis_init(struct device *dev, struct =
tpm_info *tpm_info)
> >       if (itpm || is_itpm(ACPI_COMPANION(dev)))
> >               set_bit(TPM_TIS_ITPM_WORKAROUND, &phy->priv.flags);
> >
> > +     if (settle)
> > +             set_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &phy->priv.flags=
);
> > +
> >       return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
> >                                ACPI_HANDLE(dev));
> >  }
> > diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
> > index 21d79ad3b164..68be26fa5817 100644
> > --- a/drivers/char/tpm/tpm_tis_core.c
> > +++ b/drivers/char/tpm/tpm_tis_core.c
> > @@ -184,6 +184,9 @@ static int tpm_tis_relinquish_locality(struct tpm_c=
hip *chip, int l)
> >               __tpm_tis_relinquish_locality(priv, l);
> >       mutex_unlock(&priv->locality_count_mutex);
> >
> > +     if (test_bit(TPM_TIS_SETTLE_AFTER_RELINQUISH, &priv->flags))
> > +             tpm_msleep(TPM_TIMEOUT);
> > +
> >       return 0;
> >  }
> >
> > diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis=
_core.h
> > index 6c3aa480396b..413cac5e0f31 100644
> > --- a/drivers/char/tpm/tpm_tis_core.h
> > +++ b/drivers/char/tpm/tpm_tis_core.h
> > @@ -90,6 +90,7 @@ enum tpm_tis_flags {
> >       TPM_TIS_DEFAULT_CANCELLATION    =3D 2,
> >       TPM_TIS_IRQ_TESTED              =3D 3,
> >       TPM_TIS_STATUS_VALID_RETRY      =3D 4,
> > +     TPM_TIS_SETTLE_AFTER_RELINQUISH =3D 5,
> >  };
> >
> >  struct tpm_tis_data {
> > --
> > 2.54.0
> >
>
> BR, Jarkko

