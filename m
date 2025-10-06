Return-Path: <linux-integrity+bounces-7374-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F5CBBD34E
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 09:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D023B441B
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 07:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5446523B604;
	Mon,  6 Oct 2025 07:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ASZfYQh2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD03231829
	for <linux-integrity@vger.kernel.org>; Mon,  6 Oct 2025 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759735590; cv=none; b=knRnZ0eeUbfR/VVI+eAuwYtiyAyANOD8dTic0SnvsSi3NX15g0wHN0kHMAW4+dvNAG8M2bEuqaLiMMiLcXC3Kq0jMR5sQVk6+WpHK+n5nMLrk+hGitSp7qK6baJR2Unvz1FEFye3gtPeCezZnVi34PKF2LbCAwnXk8wekhZPZLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759735590; c=relaxed/simple;
	bh=w9UxDPWeh9F0bvfmwO2t3G4sHL2zsrZM0NkrBjzg47o=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:Mime-Version:
	 References:In-Reply-To; b=SMm7zjuv/9XuvArm8wpbDXWKmtLvv6oondcL8YrTrgF/VFuOhjier5KrxpdBa3Nz8xymPoeAz5MbxTcfs2XVEa+Hy2JtCw4q9QRAZdU8kNzI29EUpvuilpEJ4ju+p+YXRS4vUHNgokn0Ju1mNHAORuRjImHW7QEo4BzOBkGRJ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ASZfYQh2; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4257aafab98so676751f8f.3
        for <linux-integrity@vger.kernel.org>; Mon, 06 Oct 2025 00:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759735586; x=1760340386; darn=vger.kernel.org;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d9z9SIVOV0Y/1ETntfvqhWbQd3xkXfiwBlHU0t6oWlM=;
        b=ASZfYQh2Q9d6hKewsQN/Sod8BIBjgR1HHJ9SORtmJHEbUipSYXHCQpKM2j07Cpbebw
         nsSEox9zTdIwsuI1NXPq7U4uNO7yQpKfgd/yF2nbMp2DzBDuPpOZBJjciL1/Z2r83l4O
         2c2f0kSyNqvVONCbtVwudHgvEFsoR16i4B50MzvyYKwfuxMedtULXOEvadeFUGWBTeVy
         Zn7wKYJRRs9zG3AbbJfC18ktHA/vlbO9k0aFf5UFuKUHdoRv/9hyxVcfVzhd3n6FF/Jw
         3KAkfOyAeLRHswlzPfqhCRCvikbPVdYzRnGhYHVEIdlLBglORls+gH7gyCyjy+I3uJlz
         sPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759735586; x=1760340386;
        h=in-reply-to:references:content-transfer-encoding:mime-version:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d9z9SIVOV0Y/1ETntfvqhWbQd3xkXfiwBlHU0t6oWlM=;
        b=s4BFXowoPlJD+b22WcNMXuNQx2k99FI1Yf3/CxzmicJrMyZJg3k+2nffC19OSmSQzH
         2PvhDqzdba3+R3CzMsAueZxcFy2ysZtfNRbL1Jaf0itdjp7R/hsa8DBph7u5tkj4qnVq
         0aFlH9dIW8aracflEj1QtrwN9yWgpU+My+V0LgC5SxULzx3HUfq9hHpnTfjK/VflK86u
         YZwREkRkSO9KuoRZ1U1zmAYk30N92hGOcva4nRAB+T05WiTlGAchiFK+MquknZf31tqZ
         dlUFAkIQMSxnCNFpzmum/5nZqdxWP7S4UMr7do1Kg/HRNnFeO6LJHAZR8MtO9fHgrPUN
         ON8g==
X-Gm-Message-State: AOJu0YyIMH+pF2lf1Cposq2+aNA0rk9hGoZCNjsFFbGwdO3HdHuchMEc
	4dblPPn+dK+Ozin1SeXOFrAdPfb/DehOwDG28CgqJdGWzXrrRuYSq9MCEvd0B6Wr+ODUR0m0fgz
	ldQ6zLpU=
X-Gm-Gg: ASbGncv6pRB2yCLfrGch9YpPhlCkjZwnYcqG9AgpsSL9LtnxnE1dxq2oLU/qUk0ob/5
	m5W0ocHOqMDCONFRVU9oAst6YbgbUx2v12D8s52DrBWffMhBiIZiLhLZVdPPGjw9pAYn+LL893E
	9GmG4AOkJi1mYWgIEwXyZYLDrn+A/fI9vMRZdl3zI+yk7u7bpAt30Ij3qNT1AHBf9fj/3dWBot9
	3B9yZXZM1FgwGfKLhDujM0TZfEX07/6Ww9JTttLqTazUonC4xiqKNvKxdUb7kbKyxDGQcsoyklA
	gSUYmwl+VrKVrP1ey+W9/Z9LDz364ygJFFMijeOsNYeazMtNYHx5AMCliROVvfsyeWDXcXQt6a4
	oG/Biq42A0i/rsq95PRD4R2v6Xzm+UJo6sCjB/YnuOVLPzsCEJLG40zLp/QIdKQcKobex6GSrna
	ctSQ==
X-Google-Smtp-Source: AGHT+IER/Rdj7cauezc+w1mEN2dXrUQVJFZHfavgAL9n3XCKJlBGmYxUCIUi5m0h1l2LcRLPVSND4w==
X-Received: by 2002:a05:6000:43d4:10b0:408:9c48:e26c with SMTP id ffacd0b85a97d-425671c6c14mr6198621f8f.62.1759735586177;
        Mon, 06 Oct 2025 00:26:26 -0700 (PDT)
Received: from localhost ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e58a7f098bsm50161851cf.28.2025.10.06.00.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 00:26:25 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 09:26:22 +0200
Message-Id: <DDB27AD5V8CC.HACBLFITNI9R@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [LTP] [PATCH 0/4] ima_{conditionals,measurements}.sh
 enhancements
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.21.0
References: <20251002083701.315334-1-pvorel@suse.cz>
In-Reply-To: <20251002083701.315334-1-pvorel@suse.cz>

hi!

On Thu Oct 2, 2025 at 10:36 AM CEST, Petr Vorel wrote:
>
> Petr Vorel (4):
>   ima_{conditionals,measurements}.sh: Add temporary user
>   ima_conditionals.sh: Split test by request
>   ima_conditionals.sh: Use 'sg' without 'sudo'
>   ima_{conditionals,measurements}.sh: Use 'su' instead of 'sudo'
>
>  runtest/ima                                   |  5 +-
>  .../integrity/ima/tests/ima_conditionals.sh   | 81 ++++++++++++-------
>  .../integrity/ima/tests/ima_measurements.sh   | 15 ++--
>  .../security/integrity/ima/tests/ima_setup.sh | 12 +++
>  4 files changed, 71 insertions(+), 42 deletions(-)

What about creating a tool simulating sudo? I thought that was our main
goal. Using 'su' is ok, but this forces us to create a new user all the
times we execute a new suite, while our new sudo implementation would
create and destroy the user only for the specific session.

- Andrea

