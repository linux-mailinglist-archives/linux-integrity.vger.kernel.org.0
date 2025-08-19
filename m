Return-Path: <linux-integrity+bounces-6877-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD60B2C652
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Aug 2025 15:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D1F3ADACD
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Aug 2025 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE05342CAF;
	Tue, 19 Aug 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fxyIppGy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACF7342C90
	for <linux-integrity@vger.kernel.org>; Tue, 19 Aug 2025 13:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755611681; cv=none; b=tU4/Ys15zqToTzG/hBtHeVlUHWBdqe7exUjwgA5/CCPmJih1CvfRtubz7l8YSO5y9cXzSETdrW+3XqVbNtnaOos0R5o4I3txSy5JikTmaU3CmBj/BtoMj5CjByj3edNKa/aFoG0UNS9aVAEkLarWeqaIp3pR6H1PWUiPzkaL57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755611681; c=relaxed/simple;
	bh=aLowlVBcGtRRCL9gPTX5iTaKpsDILmjJX+HBGaI4ZOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzOJ4NWo68dqYRyQJrpRGR1yHvtnEfxADNcPi1ZprplfXyTPgYAhCuhjlfKKyWPxlM1wFb+rhhJpnPisPipO9Ul58+9mJLZCWAr/Eq1E6piL8+3Z3PcUavb0UyHnaiVvs+gU9lI3jE1vBq0/n9dIyWUeyKEOMP2JVdUgcUwApkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fxyIppGy; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55ce5287a47so4839341e87.3
        for <linux-integrity@vger.kernel.org>; Tue, 19 Aug 2025 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755611677; x=1756216477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNBz4loD0ODJbS8mAVtRBf281KnoemFubriz2ZPRQmA=;
        b=fxyIppGyxjYasJ1keGX5g90rNsbSFKD3HNmImny+T4lOR6U3H17ratRt5UbapB5GGu
         0JDovoVzzwRC2+pca6gBgmUt8wPbz5A8hTO6zGmgE6UJRJX16jPipuVMGCs5HTVUn9dV
         XFq15DSLP3Ax1akRAwPrVnuS/hSoNNApHiqH38IQ4V5YymuIFF1otDP0NFdrAwm7sky2
         bs1GhzEf/1AWQbdwcyQSgIrpY/pOmN7FvheVBiqZphljUMbWIAtW4fWA9J5aOS/R4VgG
         QBK8PvGW8xgm/a9TIYaZPlRC322i04Ulrthf2AHi8EzyPhsNkS8JTTTS2T5rSKF6XV26
         7/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755611677; x=1756216477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNBz4loD0ODJbS8mAVtRBf281KnoemFubriz2ZPRQmA=;
        b=uOWH5q+fcQXd8NFdOzmQ0Lb2bywYmDZybiDX9d2C+HM6s48mHMLaCFrA1BLlHW/sdf
         AGimVprX3wF1wYGlZEHuqYOfqFu/evOzxCByrSFViKDuo7N5bF6eskfVHRijkSk00CRC
         jHpIJ9CPkAiCh5UdOVcFoIGZD56ZGqMVRqORGyG4uRIH0pZAPjT+AG5F48gr34i1xtUE
         XxUum3a2Cz/VdD6Ouh3a64dwVj3W2gY+s06W7NVjvlgSkSzcssupYFSXTvCezS6SNw4k
         lgcw8W70wVE7kkwl/7Tmjhc0B+0FWZOgw5QOvmsjGAtgkPvUm7iuGloIqw9SU/7ixVU1
         DkJQ==
X-Gm-Message-State: AOJu0YyZcAJdz2uGaQPFJxnsmjuCJsy71zAGitsDZvYOQIAVZNFD4AAg
	FFhUt0ljhcTdHo9dgwo7dYJ81zlDsPWTytH9Mj5POYXLCK3NpxRIa8ts3Pjjc3sZxZJDsMYUpSi
	hE3Es4Q4ahh1AMj5r5z1DS/hemnia9XKAYhZhdeArdo+UcRElsN+w4NlWdg8=
X-Gm-Gg: ASbGnctLa2ItIt2Dp2wv0ZzKT9SdKDWVLDQ5rq5KKQu6Mhtcpc8AVyOCTSphk1kOk5c
	BeZkDK4bVtApwDi0jlKh7WPJzQu2o/S9amQkiL4FiCw0nFEapwjz14ZJE6JhVKnrMqZsc36UAj7
	ceYgLl44hwXmkk//JHpEBU+VvfKPtQ7FEq3mG5XsDxDmCH3F3G3mqDa/wHmw7eZo0DWlS3st++O
	dxEI1iRy1uyy/9Bu10S4i4=
X-Google-Smtp-Source: AGHT+IGxfFV6xfLcY8QlEbP6Ssh+cXAzfw6XeqOw9QXqdrQkl4I6LdhJ6hH5tA/WeZOaWmqY+2n9oa2/0l+xtfSazDI=
X-Received: by 2002:a05:6512:3b0c:b0:55b:8f9d:f7a3 with SMTP id
 2adb3069b0e04-55e00759588mr831905e87.4.1755611676347; Tue, 19 Aug 2025
 06:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMigqh2nwuRRxaLyOJ+QaTJ+XGmkQj=rMj5K9GP1bCcXp2OsBQ@mail.gmail.com>
 <8be73a3a6772c61387b93eae808a7e382462c6cc.camel@HansenPartnership.com>
 <CAMigqh019OxTs+VaUjpEN3WoAkJnr1fJaciAELczgM9g1BMZUQ@mail.gmail.com> <517db659c835f0856daa7fa22cd4f22089111da3.camel@HansenPartnership.com>
In-Reply-To: <517db659c835f0856daa7fa22cd4f22089111da3.camel@HansenPartnership.com>
From: Chris Fenner <cfenn@google.com>
Date: Tue, 19 Aug 2025 06:54:23 -0700
X-Gm-Features: Ac12FXxy20EWdKEJDVMNOI8uNqiNe8A5WSm1YDOW89W4QEmEjxkW_sKm8SGBYYI
Message-ID: <CAMigqh0x+yK25f8J_Yrn9v93969zQxbpevivWWZ6-NLFy4pDHQ@mail.gmail.com>
Subject: Re: Questions about CONFIG_TCG_TPM2_HMAC
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks James,

On Tue, Aug 19, 2025 at 1:51=E2=80=AFAM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:

> The point being that the kernel TPM2 driver was built to support a
> standard spec TPM2 with context management.

Which "standard spec"? The PC Client Platform TPM profile? Is the TPM2
driver intended to break userspace for any other TPM?

> > 1. Where is the signing EK stored by the system?

> On durable storage.  The threat model being that an interposer attacker
> is seeking to gain access to keys or boot malicious code undetected (so
> detection, even after the fact, is good enough).

Nice, we're on the same page here, then. So let's game out this
attack. The interposer attacker has attempted to boot some malicious
code undetected, and it used its interposer capability to cause the
non-malicious firmware/bootloader/kernel code to mis-measure and
transition to the malicious code.

> > 2. When is this system (and its durable storage) validated or
> > measured?

> Usually in the initrd before root is decrypted.

I see 2 cases here, either the initrd is malicious or it's not, right?
If malicious then it will skip the checks, if not malicious what will
it check against or measure into? The interposed TPM, right?

> > 3. How do we avoid a circular trust dependency between the kernel and
> > this system here?

> If you're worried the attacker has
> compromised the system far enough to corrupt a user space crypto
> operation then you can ship the verification off to a remote system.

Indeed I am worried about this exact case, since we said earlier the
interposer is trying to boot malicious code undetected. How does the
remote system know which key the kernel used for all its salted
sessions?

Thanks
Chris

