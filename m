Return-Path: <linux-integrity+bounces-4176-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F29D42A4
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2024 20:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8F91F2241A
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Nov 2024 19:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA921AA7B1;
	Wed, 20 Nov 2024 19:44:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88413C83D;
	Wed, 20 Nov 2024 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732131893; cv=none; b=OGYPFQjFl2rZB6UGPM0KVLlawh8bjempkKUYBkgjr2OZdgKniHENb55iEzZI+UPVDtirBEfPLvwHji6EAK6KtnistKc8Mm3+XSMoriC/5inDHtHO4ZtSnaqd/0s1RAhi15AolHhbaCHs3WHkjRqkmzlgd63sVa6LiLmpPnogWRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732131893; c=relaxed/simple;
	bh=/wiwytDOUcHNNbF55kARr56LnJaKs85SIuaDjna0Bx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pjfaCDW0ZZToNdgFvXe2cKYsBbkELMLRJd41tbuxe8uX6mSgUU6/sXqwuELjpMieEFO/MTfHQkIgX9F/TjqcYWtHC/81wxiC0T4av5BfRCgVSxGNKwPosATaJDF8B/uIWTIWTh90kmlC7B1HxuZbA9FHJ3AEritl2yx/aer3fW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfa90e04c2so85581a12.1;
        Wed, 20 Nov 2024 11:44:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732131890; x=1732736690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THRi3sy/5qC0fUASXvWioXtk0quT9gz69AznhmP0uAU=;
        b=UfD7GMDc0S1yWw5NHjniLfXDXfc0MNwLydrz7kmTBx8OVUzKiob5EGpzP8OWGR03sn
         hnx9IC1XPomedBnoENZOl3hI1QBzNFD3XaVu1/cCGsV0bdH8YUNmXhAAmjNRT2Ufx8ME
         SaO3uZiEeUOLrDkbHPQHXK4JYucL0WrKx23gOaVn20Zzf357bUtwbQs68CdJbKoPcvXq
         nFotKc3Z6yHlBO2/b+wN62vf8X+X8LDtTq7O1nOCLx1+Gzf3JEOYK2RmVVlT/Iui043e
         PuOLeAzRy2hCzemtay6giJx38NSzZr6v7JsYZILTBZ4rYtFlSeKQK53xdko88hjgL+NM
         QG4g==
X-Forwarded-Encrypted: i=1; AJvYcCUKOuqSvl6rPAw40qGImwjqvi2vvBtuwjlEtqg4nBH+vcZ2KqheCYkGnpNXs8ooe162Ri8u96amWbiM6HUb@vger.kernel.org, AJvYcCWLG4xIjU7ZfA/JeCTYKGuVdTwevKXx1O1PmQRulIMHeHE+3lh1d9WpjCp/WDxzhi4hBf3A1d5a60ucIuCePuo=@vger.kernel.org, AJvYcCWreHQGdPI2kapt0AHzPs1j2P5TrVUUAQSALdquEt3cKRdornwIhUQw2D1i+IUygi57ZA16dgDs3r4lSCEAosyRKiuwiVOb@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjXOdLCO5F7aHHUGf7Lv26SXBcaj35BgIYDtvujTei09xI9Wq
	vrA0q63XGosqUxhSBvrCGxJv1kI94chBHo5w43gr1tQ5MQxhY/gy
X-Gm-Gg: ASbGncsKaR+TFayHPY5qqZoi4hyNi8dYzWKtEvsE38iwiLv2283XoDNnKZeeODrvgu3
	BGGl9vxNaUCrjVqO4nX0/xDi/zYuP3tbW1DzXvBtpaAQKRm36YvXCuGGeCUiwDk5hLP/F1GaZW2
	fzgtdGA+eHgWNU+zGCwh4xpb2qQuYmdVq/XXN99CNM89XER316hAOa47n1xEnlozhoiODRScU6V
	AM9SmBMEp/jLrZ+PrVc2KdUq4f3K2p/plVcs0FVY9U6N88=
X-Google-Smtp-Source: AGHT+IFydFiruA8tqHqM/ls2aflXZ4jqqlwr3HW3n3VmZyZisUMwDNoaSegIST8iHiz4H6TlviaeNA==
X-Received: by 2002:a17:907:1c0d:b0:a99:f0cf:f571 with SMTP id a640c23a62f3a-aa4dd57e0b9mr365748666b.33.1732131889496;
        Wed, 20 Nov 2024 11:44:49 -0800 (PST)
Received: from gmail.com ([2620:10d:c092:400::5:a87e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df265bbsm805833766b.38.2024.11.20.11.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 11:44:49 -0800 (PST)
Date: Wed, 20 Nov 2024 19:44:46 +0000
From: Breno Leitao <leitao@debian.org>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	noodles@earth.li
Subject: Re: [PATCH] ima: kexec: Add RCU read lock protection for
 ima_measurements list traversal
Message-ID: <Zz48LjTS_r-j9Qny@gmail.com>
References: <20241104-ima_rcu-v1-1-5157460c5907@debian.org>
 <b89a084a98e7427911ac4344225eca99a04a52fb.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b89a084a98e7427911ac4344225eca99a04a52fb.camel@linux.ibm.com>

Hello Mimi,

On Tue, Nov 19, 2024 at 01:10:10PM -0500, Mimi Zohar wrote:
> Hi Breno,
> 
> On Mon, 2024-11-04 at 02:47 -0800, Breno Leitao wrote:
> > Fix a potential RCU issue where ima_measurements list is traversed using
> > list_for_each_entry_rcu() without proper RCU read lock protection. This
> > caused warnings when CONFIG_PROVE_RCU was enabled:
> > 
> >   security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-reader section!!
> > 
> > Add rcu_read_lock() before iterating over ima_measurements list to ensure
> > proper RCU synchronization, consistent with other RCU list traversals in
> > the codebase.
> 
> The synchronization is to prevent freeing of data while walking the RCU list. In
> this case, new measurements are only appended to the IMA measurement list.  So
> there shouldn't be an issue.
> 
> The IMA measurement list is being copied during kexec "load", while other
> processes are still running.  Depending on the IMA policy, the kexec "load",
> itself, and these other processes may result in additional measurements, which
> should be copied across kexec.  Adding the rcu_read_{lock, unlock} would
> unnecessarily prevent them from being copied.

Thank you for the detailed explanation. Since rcu_read_lock() operations are
lightweight, I believe keeping them wouldn't impact performance significantly.

However, if you prefer the lockless approach, I would suggest adding an
argument to list_for_each_entry_rcu() to keep the warning out. What are
your thoughts on this?

Author: Breno Leitao <leitao@debian.org>
Date:   Mon Nov 4 02:26:45 2024 -0800

    ima: kexec: silence RCU list traversal warning

    The ima_measurements list is append-only and doesn't require rcu_read_lock()
    protection. However, lockdep issues a warning when traversing RCU lists
    without the read lock:

      security/integrity/ima/ima_kexec.c:40 RCU-list traversed in non-reader section!!

    Fix this by using the lockless variant of list_for_each_entry_rcu() with
    the last argument set to true. This tells the RCU subsystem that
    traversing this append-only list without the read lock is intentional
    and safe.

    This change silences the lockdep warning while maintaining the correct
    semantics for the append-only list traversal.

    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 52e00332defed..9d45f4d26f731 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -37,7 +37,8 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,

 	memset(&khdr, 0, sizeof(khdr));
 	khdr.version = 1;
-	list_for_each_entry_rcu(qe, &ima_measurements, later) {
+	/* This is an append-only list, no need to hold the RCU read lock */
+	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
 		if (file.count < file.size) {
 			khdr.count++;
 			ima_measurements_show(&file, qe);


