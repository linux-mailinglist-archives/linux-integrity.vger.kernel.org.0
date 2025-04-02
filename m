Return-Path: <linux-integrity+bounces-5541-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3B2A7863B
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 03:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B927A2C3C
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Apr 2025 01:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B24CEC2;
	Wed,  2 Apr 2025 01:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKuxbzQG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12232E3386
	for <linux-integrity@vger.kernel.org>; Wed,  2 Apr 2025 01:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743558405; cv=none; b=d5PPDuh91soHMLEESG5kCukQEMP52A+Mcn+9wDfo2luRBINiKOemWAw9sTs/7xSwy7z4xD4PmdNu6i0/iQL3FzFAWLn18onZqlIk6hKX7ctnx2cxaAHb3NpxFTTetMYK8J2s2ihYhRKPq8g2TGnkKPHd5cLZlbdc2Q797eAEnYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743558405; c=relaxed/simple;
	bh=x127oMytbNe6zMmN3SKf/vI4ViGiEAK9vdkyCvrdGvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtdysKGaGgx5H+mDsN4qn7VHT+AsJKrK3eCCiOu1I3YUOjltsb62T++J4H5lFTKFdX7Mccm2f3iGagaQVePiRljhaKtxtB/xqGciy//f6CLzdYtuSx272UyG3c7KNYdXfG1J3rGKfe9+3BIx0chkcsQOi49uYKqvST7sCTZ6N7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SKuxbzQG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743558402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esIx3FLgUyECr9heAFo1/Ans5T4q1I6Sd+VAOR0d4fY=;
	b=SKuxbzQGvVkthqjaO1b7AAGJH49noPAmJ6LebFSYtQRBALVcSzdTdQT3d6aeiuocjHUYvr
	LoDbRxfiki26pH4hPVLf2YxoinrxZ/XJEzkpNb7itAakLXIJtUO0wRgnHLu3xyLdxO6aPP
	95Z+0oppO0vX0rlMxqiv3yo2dhghVIo=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-mWjtXDBlMcaW1FuYI-sAHA-1; Tue, 01 Apr 2025 21:46:41 -0400
X-MC-Unique: mWjtXDBlMcaW1FuYI-sAHA-1
X-Mimecast-MFC-AGG-ID: mWjtXDBlMcaW1FuYI-sAHA_1743558400
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3d443811f04so64172255ab.1
        for <linux-integrity@vger.kernel.org>; Tue, 01 Apr 2025 18:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743558400; x=1744163200;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=esIx3FLgUyECr9heAFo1/Ans5T4q1I6Sd+VAOR0d4fY=;
        b=NHphY+wegYrHLqM9dIcR54NTW/0a3D//DYoH2TKkNUg5PKH3sIoAtBXO5IXp1Jszt2
         W1slcTHkT5ef8b9Nmm1rg+ThkJU/uSi4/4h81hdaj2BTybJNv/7gBXBGLExAV0NWRJni
         TT4eIgaOQpOCc5VbIl+y3WlCkobeJCz3QJGTTgOoiBvACktPbAiTz7ZAi/Dygf92wj9i
         in/piaHUu89feLSord0ERaWiv0qqmObD57T2YgF0zgp19mjYCTgYEiyFbDjdV9sF0K1X
         yditMB45VoB+/HGkhOIH1Ro4gB5SErWXko6auc9AaE3rMkNn3KhlujpGzlGZ1QP80CLz
         /bfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV59sYVTkEu37fZzOtSNgJ6BdKoGGwdP7Az8OHmBjsXWy9Oer2Gs+iCAV6xFaiKHpDfXKia9UipQcU7TPeBHFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYR0KEiV5Nx9yIIKt2WYKATN5yOqSDJTUeDTuV9/jMXKHXEKCO
	uF8jUX4Zd2CMn752W0968IX8EIs+UclDK/dalfvY1wxFcfnaog0xV9kYGo+vYU1k44tjVThmCwk
	g9EaA1G+IV0TYmnxh/lmLuWmRwWGUYhAmlTWtOIb26+gXojGwmNyi8slMIk+Av4/ceZwj/ym1rE
	/3b2fRd4B3il4KB7brORQqou9HLMlrLimieJ75tMcP
X-Gm-Gg: ASbGncumirekfmyUW32V5No83TvZEglvGTupltsyiI5H0Cs63PP3fBHzc0ajf4WdnnG
	dEY9QCEMajNFgrn3hxVJ094T72casdRxrHrjx412IPVT2WgTDN2wA9SpibySvANp1fctFiGuybA
	==
X-Received: by 2002:a05:6e02:1a61:b0:3d2:bac3:b45f with SMTP id e9e14a558f8ab-3d5e08ea950mr170102215ab.4.1743558400408;
        Tue, 01 Apr 2025 18:46:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXXL/DGOEKBaPDll5ERFe7X9clUCsdL8rJLlHEQdb+JT8lEhX7G9wZM//WuiBK0lbpMEn92VoHj13w3iRbxh4=
X-Received: by 2002:a05:6e02:1a61:b0:3d2:bac3:b45f with SMTP id
 e9e14a558f8ab-3d5e08ea950mr170102145ab.4.1743558400061; Tue, 01 Apr 2025
 18:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331061611.253919-1-bhe@redhat.com> <b1eba83a9f68ed9a19100f6c0dc5aca7aff437d5.camel@linux.ibm.com>
 <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
In-Reply-To: <fv7h5jfb4r6d5j6jjpgyjbv75zyzqpy6tbqn3ahzuewghnvrgd@5yclg75kr3cq>
From: RuiRui Yang <ruyang@redhat.com>
Date: Wed, 2 Apr 2025 09:47:04 +0800
X-Gm-Features: AQ5f1JqULEGvBbKdWyJ41Pxye25onthjjCVVmAY72XXy0WH85DAaqOpxLxCIZjc
Message-ID: <CALu+AoQrKunS5RjikkcZD7=J9vwhv1_Dw96fmO0EtyKi0MHHJg@mail.gmail.com>
Subject: Re: [RFC PATCH] ima: add a knob to make IMA be able to be disabled
To: Coiby Xu <coxu@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>, linux-integrity@vger.kernel.org, 
	kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 09:41, Coiby Xu <coxu@redhat.com> wrote:
>
> On Mon, Mar 31, 2025 at 08:15:08AM -0400, Mimi Zohar wrote:
> >On Mon, 2025-03-31 at 14:16 +0800, Baoquan He wrote:
> >> It doesn't make sense to run IMA functionality in kdump kernel, and that
> >> will cost extra memory. It would be great to allow IMA to be disabled on
> >> purpose, e.g for kdump kernel.
> >>
> >> Hence add a knob here to allow people to disable IMA if needed.
> >>
> >> Signed-off-by: Baoquan He <bhe@redhat.com>
> >> ---
> >>  security/integrity/ima/ima_main.c | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> >>
> >> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> >> index 28b8b0db6f9b..5d677d1389fe 100644
> >> --- a/security/integrity/ima/ima_main.c
> >> +++ b/security/integrity/ima/ima_main.c
> >> @@ -38,11 +38,27 @@ int ima_appraise;
> >>
> >>  int __ro_after_init ima_hash_algo = HASH_ALGO_SHA1;
> >>  static int hash_setup_done;
> >> +static int ima_disabled = 0;
> >>
> >>  static struct notifier_block ima_lsm_policy_notifier = {
> >>      .notifier_call = ima_lsm_policy_change,
> >>  };
> >>
> >> +static int __init ima_setup(char *str)
> >> +{
> >> +    if (strncmp(str, "off", 3) == 0)
> >> +                ima_disabled = 1;
> >> +        else if (strncmp(str, "on", 2) == 0)
> >> +                ima_disabled = 0;
> >> +        else
> >> +                pr_err("invalid ima setup option: \"%s\" ", str);
> >> +
> >> +    return 1;
> >> +}
> >> +__setup("ima=", ima_setup);
> >
> >I understand your wanting to disable IMA for Kdump, but this goes way beyond
> >that.  Please don't make it generic like this.
> >
> >Please refer to ima_appraise_parse_cmdline().
>
> Hi Mimi,
>
> To save memory for kdump, it seems init_ima has been to be skipped thus
> ima=off is necessary (ima_appraise=off won't serve the purpose). Or do
> you have any specific concerns in mind?

I think as Mimi said see below logic enforces the IMA even with the
cmdline disabling, see ima_appraise_parse_cmdline:
if (sb_state) {
                if (!(appraisal_state & IMA_APPRAISE_ENFORCE))
                        pr_info("Secure boot enabled: ignoring
ima_appraise=%s option",
                                str);
        } else {
                ima_appraise = appraisal_state;
        }


>
> >
> >Mimi
> >
> >> +
> >> +
> >> +
> >>  static int __init hash_setup(char *str)
> >>  {
> >>      struct ima_template_desc *template_desc = ima_template_desc_current();
> >> @@ -1176,6 +1192,11 @@ static int __init init_ima(void)
> >>  {
> >>      int error;
> >>
> >> +    if (ima_disabled) {
> >> +            pr_info("IMA functionality is disabled on purpose!");
> >> +            return 0;
> >> +    }
> >> +
> >>      ima_appraise_parse_cmdline();
> >>      ima_init_template_list();
> >>      hash_setup(CONFIG_IMA_DEFAULT_HASH);
> >
> >
>
> --
> Best regards,
> Coiby
>
>


