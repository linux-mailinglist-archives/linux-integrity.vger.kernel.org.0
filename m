Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1B3678F32
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 05:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjAXEQf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Jan 2023 23:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAXEQe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jan 2023 23:16:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5182E0E9;
        Mon, 23 Jan 2023 20:16:32 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id be8so670225plb.7;
        Mon, 23 Jan 2023 20:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1urGv0mHJ7YJYJNJOzM1m8Twx0srW6ZZUopL2pa7yvk=;
        b=prWn9RufzbUdIxdrCBTqxlvlDhB2nZTXXo9FuZLk4bJa65H6zYekYGRzNiJNrKfZg3
         UgcSiCo/D69OjJEYuwoEmgNLA/VYs7dl9gumw8ynQnWf651mpvbumodhdQt7UhERqwM3
         fdM9/jmZ84IoEds5rX0kzv4rhs/lb8m3RV1uZZvoj+dqRJ/3eiEBUk71T+MmMCtFvCmG
         3VCkyxjbVOQtfwTXVRiXK1+x2JYWpNPqugwwyEMBPdfk0M+zTNMYCAnP8ujfNu9IC+om
         KP67nyALTqSNFyHPgM/Ik2eE3iXITmzFBuLiLAUWanZlt/st1Wf0K3YKnS0pcvk0yQ10
         9SAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1urGv0mHJ7YJYJNJOzM1m8Twx0srW6ZZUopL2pa7yvk=;
        b=pxNp4a3a8E93HYRKkrUX9+m6hyPWD5l5O86aMCrDue/TmXve5xmmLzVkWpahJ3QbS5
         PffdmLIp+V6lWZa3AWdrh7OjnPgkq/TWQemtCNYotsULjDOVzX74559C2QIbE7a3zVYa
         VOV430jVCEwqOtb7b2gm8BsJDXVB4PYcjoZNTlhGCA1NRRZ//JYpjg2FSOnNijFn4VQA
         Ntmp7miQenw0iPDChN8hvDu5pfr+Naz0FhZZgPIGP3dRWAnZGEce52Y4fbVyKynMHHSO
         cpr0TOW3DuQHqegz+d44IGUwZjuSPMkD3PF4O+IbpGi2BgzfiqydiocWd4EBnkYLldBs
         pmMw==
X-Gm-Message-State: AFqh2krldjB0EvjBRcegf1sZPW6Kgy0kkJwAf9CwfMy1IoooKz8k4g9v
        FX5wVi5givkRAxguhTN+MLxANCFq9pU4wQ==
X-Google-Smtp-Source: AMrXdXuSVtrTllW9RCM77BotoTrsr7sGbJ91c+Msy2yWlokuP6tycoBTZ9CnrNQiDLj02Dfj8ugNzg==
X-Received: by 2002:a05:6a20:4c8a:b0:b8:8e17:901c with SMTP id fq10-20020a056a204c8a00b000b88e17901cmr24234111pzb.52.1674533792376;
        Mon, 23 Jan 2023 20:16:32 -0800 (PST)
Received: from localhost (121-44-64-35.tpgi.com.au. [121.44.64.35])
        by smtp.gmail.com with ESMTPSA id b20-20020a170902d31400b0019603cb63d4sm487043plc.280.2023.01.23.20.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 20:16:31 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 24 Jan 2023 14:16:24 +1000
Message-Id: <CQ04OOT6CW1A.MCLZN2B4BTWK@bobo>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>, <ruscur@russell.cc>,
        <gcwilson@linux.ibm.com>, <joel@jms.id.au>
Subject: Re: [PATCH v4 16/24] powerpc/pseries: Implement signed update for
 PLPKS objects
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-17-ajd@linux.ibm.com>
In-Reply-To: <20230120074306.1326298-17-ajd@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri Jan 20, 2023 at 5:42 PM AEST, Andrew Donnellan wrote:
> From: Nayna Jain <nayna@linux.ibm.com>
>
> The Platform Keystore provides a signed update interface which can be use=
d
> to create, replace or append to certain variables in the PKS in a secure
> fashion, with the hypervisor requiring that the update be signed using th=
e
> Platform Key.
>
> Implement an interface to the H_PKS_SIGNED_UPDATE hcall in the plpks
> driver to allow signed updates to PKS objects.
>
> (The plpks driver doesn't need to do any cryptography or otherwise handle
> the actual signed variable contents - that will be handled by userspace
> tooling.)
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> [ajd: split patch, add timeout handling and misc cleanups]
> Co-developed-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
>
> ---
>
> v3: Merge plpks fixes and signed update series with secvar series
>
>     Fix error code handling in plpks_confirm_object_flushed() (ruscur)
>
>     Pass plpks_var struct to plpks_signed_update_var() by reference (mpe)
>
>     Consistent constant naming scheme (ruscur)
>
> v4: Fix MAX_HCALL_OPCODE rebasing issue (npiggin)
> ---
>  arch/powerpc/include/asm/hvcall.h      |  1 +
>  arch/powerpc/include/asm/plpks.h       |  5 ++
>  arch/powerpc/platforms/pseries/plpks.c | 71 ++++++++++++++++++++++++--
>  3 files changed, 72 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm=
/hvcall.h
> index 95fd7f9485d5..c099780385dd 100644
> --- a/arch/powerpc/include/asm/hvcall.h
> +++ b/arch/powerpc/include/asm/hvcall.h
> @@ -335,6 +335,7 @@
>  #define H_RPT_INVALIDATE	0x448
>  #define H_SCM_FLUSH		0x44C
>  #define H_GET_ENERGY_SCALE_INFO	0x450
> +#define H_PKS_SIGNED_UPDATE	0x454
>  #define H_WATCHDOG		0x45C
>  #define MAX_HCALL_OPCODE	H_WATCHDOG
> =20
> diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/=
plpks.h
> index 7c5f51a9af7c..e7204e6c0ca4 100644
> --- a/arch/powerpc/include/asm/plpks.h
> +++ b/arch/powerpc/include/asm/plpks.h
> @@ -68,6 +68,11 @@ struct plpks_var_name_list {
>  	struct plpks_var_name varlist[];
>  };
> =20
> +/**
> + * Updates the authenticated variable. It expects NULL as the component.
> + */
> +int plpks_signed_update_var(struct plpks_var *var, u64 flags);
> +
>  /**
>   * Writes the specified var and its data to PKS.
>   * Any caller of PKS driver should present a valid component type for
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platfo=
rms/pseries/plpks.c
> index 1189246b03dc..796ed5544ee5 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -81,6 +81,12 @@ static int pseries_status_to_err(int rc)
>  		err =3D -ENOENT;
>  		break;
>  	case H_BUSY:
> +	case H_LONG_BUSY_ORDER_1_MSEC:
> +	case H_LONG_BUSY_ORDER_10_MSEC:
> +	case H_LONG_BUSY_ORDER_100_MSEC:
> +	case H_LONG_BUSY_ORDER_1_SEC:
> +	case H_LONG_BUSY_ORDER_10_SEC:
> +	case H_LONG_BUSY_ORDER_100_SEC:
>  		err =3D -EBUSY;
>  		break;
>  	case H_AUTHORITY:

This is a bit sad to maintain here. It's duplicating bits with
hvcs_convert, and a bunch of open coded places. Probably not the
series to do anything about. Would be nice if we could standardise
it though.

> @@ -184,14 +190,17 @@ static struct label *construct_label(char *componen=
t, u8 varos, u8 *name,
>  				     u16 namelen)
>  {
>  	struct label *label;
> -	size_t slen;
> +	size_t slen =3D 0;
> =20
>  	if (!name || namelen > PLPKS_MAX_NAME_SIZE)
>  		return ERR_PTR(-EINVAL);
> =20
> -	slen =3D strlen(component);
> -	if (component && slen > sizeof(label->attr.prefix))
> -		return ERR_PTR(-EINVAL);
> +	// Support NULL component for signed updates
> +	if (component) {
> +		slen =3D strlen(component);
> +		if (slen > sizeof(label->attr.prefix))
> +			return ERR_PTR(-EINVAL);
> +	}

Is this already a bug? Code checks for component !=3D NULL but previously
calls strlen which would oops on NULL component AFAIKS. Granted nothing
is actually using any of this these days.

It already seems like it's supposed to be allowed to rad NULL component
with read_var though? Why the differences, why not always allow NULL
component? (I assume there is some reason, I just don't know anything
about secvar or secure boot).

> =20
>  	// The label structure must not cross a page boundary, so we align to t=
he next power of 2
>  	label =3D kzalloc(roundup_pow_of_two(sizeof(*label)), GFP_KERNEL);
> @@ -397,6 +406,58 @@ static int plpks_confirm_object_flushed(struct label=
 *label,
>  	return pseries_status_to_err(rc);
>  }
> =20
> +int plpks_signed_update_var(struct plpks_var *var, u64 flags)
> +{
> +	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] =3D {0};
> +	int rc;
> +	struct label *label;
> +	struct plpks_auth *auth;
> +	u64 continuetoken =3D 0;
> +	u64 timeout =3D 0;
> +
> +	if (!var->data || var->datalen <=3D 0 || var->namelen > PLPKS_MAX_NAME_=
SIZE)
> +		return -EINVAL;
> +
> +	if (!(var->policy & PLPKS_SIGNEDUPDATE))
> +		return -EINVAL;
> +
> +	auth =3D construct_auth(PLPKS_OS_OWNER);
> +	if (IS_ERR(auth))
> +		return PTR_ERR(auth);
> +
> +	label =3D construct_label(var->component, var->os, var->name, var->name=
len);
> +	if (IS_ERR(label)) {
> +		rc =3D PTR_ERR(label);
> +		goto out;
> +	}
> +
> +	do {
> +		rc =3D plpar_hcall9(H_PKS_SIGNED_UPDATE, retbuf,
> +				  virt_to_phys(auth), virt_to_phys(label),
> +				  label->size, var->policy, flags,
> +				  virt_to_phys(var->data), var->datalen,
> +				  continuetoken);
> +
> +		continuetoken =3D retbuf[0];
> +		if (pseries_status_to_err(rc) =3D=3D -EBUSY) {
> +			int delay_ms =3D get_longbusy_msecs(rc);
> +			mdelay(delay_ms);
> +			timeout +=3D delay_ms;
> +		}
> +		rc =3D pseries_status_to_err(rc);
> +	} while (rc =3D=3D -EBUSY && timeout < PLPKS_MAX_TIMEOUT);
> +
> +	if (!rc)
> +		rc =3D plpks_confirm_object_flushed(label, auth);
> +
> +	kfree(label);
> +out:
> +	kfree(auth);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL(plpks_signed_update_var);

Sorry I missed it before -- can this be a _GPL export?

Thanks,
Nick
