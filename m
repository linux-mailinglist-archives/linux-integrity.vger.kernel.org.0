Return-Path: <linux-integrity+bounces-7481-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CC6BEBC65
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA2A7354279
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700CD27E07E;
	Fri, 17 Oct 2025 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NoSzkU8y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92512848A7
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734775; cv=none; b=T/o6q/lF34YfvHGVOPnbqqcfBR508AAeNFpLO/La3gWcW2BjAYA5ndeJ2L+1M3Ljgy/mWd3mtcJSo10zj1JGpYN+gZRkRa2QnOC+1uZ7j5eTwttislfZiDj3ORR3IOyxSEISp0JCkZinK8O4H3+2/vV8iSwSG6MosAkvOqmkAEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734775; c=relaxed/simple;
	bh=e89QIJCu3NnHGbEpfJbSpPegYSPtflNrZ3i6VCWhESY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qF1sA14pU26MbhoIVdu2ZCdCRSBv4VLMaF7RkyYmDkWsM6NhlbBKoBy/Fuqe3zueUQHV+fWO1e/Tugz1TaOn5MTpqlZOblYXI/Il8h41g2GRcH6t8jaJLusHJCr9hBH8Ce+Le/Kq2TQKqmY9y45KGYyd4Nm86RjJSd0liA3q8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NoSzkU8y; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33be037cf73so1109976a91.2
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734772; x=1761339572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX8ZaKICkZurP7qqp4KURNWhEfVEFdZ1NxO3hfLjNng=;
        b=NoSzkU8yDcKT0YuOcj/ZrfWzZtsEMw/Vgntb5nBwMg4xBhVmk1kEgd8CznySNPOGsm
         Y+sujLTd0utNMGOoTIhfyrSw7X7uect64cxyzucRYq+rqfJisT0d166ZxzJStSQlzY+J
         MiX5UaTF7rRrdBYETlqxP2b15nL7K70JC8EZMlw01crKLOr2P9Xr8MUmXn56KgRiycCV
         cJxvd5MJfWdDTNrU3wgl8d00xXlJD1BMkwbVBdWHEOhNFB2IdG4ejBgTwzJvtjR741Vp
         uQmI/XKpzieN6xR6jytUvnsjDnB5JLYAWFomzPR4FbMv2UZf6K7hErLgvAmYAxRnlhSL
         z9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734772; x=1761339572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OX8ZaKICkZurP7qqp4KURNWhEfVEFdZ1NxO3hfLjNng=;
        b=HUq5J5sDMJCPG2FED+DijYP99J0Q8XzyH7FfSDyiSnV+sSNmg+cJfzQYNcWLoagRre
         scHdImj0/ZIE9XkJsQrfdCaGtRITo7eePePLk0rHHiOYhaQcwHorkhm1zGuHpI8aSjfq
         a4qEhmHlncM28Owbx1Jvn1t6ATfAKIEcW3C77YseUUQPnN/8Tbpy3IxGE1XAZmQ/spDn
         5LYqs9bgDCeTqoEXBT81hBsZcbpcw917EKpVZclXFcvQ2c6z8MLILzZwln/rYH/r8a/k
         t5aSGqSS+3J0uBG38RAuZNfUkYnIudEESLNdYXeu7w7wv4Wjhq1VIHvxk06fS6K5ISfy
         d57w==
X-Forwarded-Encrypted: i=1; AJvYcCW6sTPDwtsmjkscPcdhJrLvg5F3D8avSvp04uHNfmv+qnPB3QilKJoxMbMVIEoXfzJB4d6imw9h+InlpicquqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2L3Yn017ioo9/EQ+XjheTNiscsswSbEYpqsraiQ1ytcQLLsas
	Cm8pClLpu+Oy5PU/8Iskxo5BKkDmjWrfSNwHBuGn5NR3fmSn08teOtfi0sEmz2WaoS0GgGjU+LB
	/wXal89xGAAKCqEQtygU9XpNln3065bb2gw6OhFa6
X-Gm-Gg: ASbGnct2IbvJQ6GmvVLSi9vKF/TNnOedRdCwlAECT6Grsj+X5JE6pbshBm+ZMbPgs7M
	ocGvYGXttlW9MYwGzkDJw1AaZLQR0320oBAGjyLn7IQJqMYZi8od+1ZoVttj/87Bo9rGsw2teil
	XYvajs64G30IFG25KxN6zoQd77OJngT68vG+rLtBYEboUicvwicew1+YL5Dwsf5ihoI8iPRdba/
	nq3lOVq1tu6EzqKf0XoIR/uGSPe/UKCSOr9U+Ke3kN6rEec2SnpckAbfSB6
X-Google-Smtp-Source: AGHT+IG6Kfu9K0+lk1D/XHIKhGtwsLPifmxM0P9K47LcIIkEjMChq9PCvHEQylirdUvNTwoNhDEZ9jFZTS5klPcwwvI=
X-Received: by 2002:a17:90b:2d8f:b0:335:2eee:19dc with SMTP id
 98e67ed59e1d1-33bcf8f94b6mr5743064a91.28.1760734772116; Fri, 17 Oct 2025
 13:59:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017202456.484010-36-paul@paul-moore.com>
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Oct 2025 16:59:20 -0400
X-Gm-Features: AS18NWDsPyC9L0XdCHx2z67n5R5ykR1KRnY-DeF8JpDQJR5U7ZFMG7NWetREIEU
Message-ID: <CAHC9VhQK9Lf3ENmzxR6QLvj=PhWgPWD2_irLyYu9AxEsJ9raCg@mail.gmail.com>
Subject: Re: [PATCH v5 0/34] Rework the LSM initialization
To: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 4:28=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> This is the fifth, and likely final, revision of the LSM rework patchset.
> The number of changes in this revision are very minor and barring any
> surprises I expect to merge this into the lsm/dev branch next week; I'll
> send a notice when I do.  While there isn't anything in this revision
> that people haven't seen previously, if you do have any concerns or
> feedback, please let me know.  Once again, thank you to all of you that
> have taken the time to review these patches.
>
> I've aldo updated the working-lsm_init_rework branch of the main LSM
> tree to contain the latest v5 revision of the patchset:
> https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git/log/?h=3D=
working-lsm_init_rework
>
> The v4 patchset:
> https://lore.kernel.org/linux-security-module/20250916220355.252592-36-pa=
ul@paul-moore.com/
>
> The RFC/v3 patchset:
> https://lore.kernel.org/linux-security-module/20250814225159.275901-36-pa=
ul@paul-moore.com/
>
> The RFC/v2 patchset:
> https://lore.kernel.org/linux-security-module/20250721232142.77224-36-pau=
l@paul-moore.com/
>
> The RFC/v1 patchset is below, the cover letter provides some background
> and motivation for this series which still applies:
> https://lore.kernel.org/linux-security-module/20250409185019.238841-31-pa=
ul@paul-moore.com/
>
> CHANGELOG
> v5:
> - rebased to lsm/dev branch post v6.18-rc1
> - fixed a !CONFIG_SECURITYFS bug (kernel test robot)
> - fixed a missing "__rcu" annotation on a cast (kernel test robot)
> v4:
> - reworked the lsm_read() function (John, Roberto, Tetsuo)
> - replaced the IMA/EVM patch with one from Roberto
> RFC/v3:
> - rebased to lsm/dev branch
> - fixed IMA/EVM initcall comment (Roberto)
> - fixed CONFIG_IMA and CONFIG_EVM problems (Nicolas, Roberto)
> - fixed CONFIG_SECURITY_SMACK_NETFILTER problems (Roberto)
> - fixed the IMA/EVM header file include macro protections
> - fixed an off-by-one string length issue in lsm_read() (Casey)
> RFC/v2:
> - rename lsm_prep_single() to lsm_prepare()
> - drop the lsm_prop counting patch
> - drop the platform_certs changes from the IMA/EVM patch (Mimi)
> - split/reorder anough patches in the patchset that I lost track
> - added missing function comment blocks in the SELinux patches
> - split patch 04/29 into smaller patches (Kees)
> - fix an LSM list output problem in an intermediate patch (Kees)
> - preserve the "lsm_active_cnt" variable name (Casey)
> - cache the lsm_read() string (Kees)
> - squashed, split, and reordered the enabled/ordering patches
> - reworked the Smack patch (Casey)
> - conditionalized the SELinux IB init code (Stephen)
> - fixed missing Smack "__init" annotation (Fan)
> - fixed a potential unused variable warning in IMA/EVM (John)
> - fixed the placeholder commit descriptions (various)
> RFC/v1:
> - initial version
>
> --
> Paul Moore (33):
>       lsm: split the notifier code out into lsm_notifier.c
>       lsm: split the init code out into lsm_init.c
>       lsm: consolidate lsm_allowed() and prepare_lsm() into
>          lsm_prepare()
>       lsm: introduce looping macros for the initialization code
>       lsm: integrate report_lsm_order() code into caller
>       lsm: integrate lsm_early_cred() and lsm_early_task() into caller
>       lsm: rename ordered_lsm_init() to lsm_init_ordered()
>       lsm: replace the name field with a pointer to the lsm_id struct
>       lsm: rename the lsm order variables for consistency
>       lsm: rework lsm_active_cnt and lsm_idlist[]
>       lsm: get rid of the lsm_names list and do some cleanup
>       lsm: rework the LSM enable/disable setter/getter functions
>       lsm: rename exists_ordered_lsm() to lsm_order_exists()
>       lsm: rename/rework append_ordered_lsm() into lsm_order_append()
>       lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
>       lsm: cleanup the LSM blob size code
>       lsm: cleanup initialize_lsm() and rename to lsm_init_single()
>       lsm: fold lsm_init_ordered() into security_init()
>       lsm: add/tweak function header comment blocks in lsm_init.c
>       lsm: cleanup the debug and console output in lsm_init.c
>       lsm: output available LSMs when debugging
>       lsm: group lsm_order_parse() with the other lsm_order_*()
>          functions
>       lsm: introduce an initcall mechanism into the LSM framework
>       loadpin: move initcalls to the LSM framework
>       ipe: move initcalls to the LSM framework
>       smack: move initcalls to the LSM framework
>       tomoyo: move initcalls to the LSM framework
>       safesetid: move initcalls to the LSM framework
>       apparmor: move initcalls to the LSM framework
>       lockdown: move initcalls to the LSM framework
>       selinux: move initcalls to the LSM framework
>       lsm: consolidate all of the LSM framework initcalls
>       lsm: add a LSM_STARTED_ALL notification event
>
> Roberto Sassu (1):
>       ima,evm: move initcalls to the LSM framework

Unfortunately I ran into a mail throttling issue when sending this
patchset and my initial post only contained the first 22 patches, so I
resent patches 23 through 34.  While I set the reply-to header
properly, the remaining patches should be threaded under the cover
letter, the numbering was reset to that patch 23/34 appears as patch
01/11.  Sigh.

My apologies, I thought this would be preferable to resending the full
patchset, and potentially getting throttled again.

As this revision is fairly minor, and everyone that *needs* to review
the patchset has already, I'm going to leave things as-is on the list.
All of the patches are present in that thread, the numbering is just a
little wonky.  If there is any concern about ordering, you can always
check the git repo mentioned in the cover letter.

Once again, sorry for the confusion, I've never hit throttling like
that before, but if it becomes a regular problem I'll make adjustments
to prevent it from becoming more of an issue.

--=20
paul-moore.com

