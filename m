Return-Path: <linux-integrity+bounces-3368-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A958957676
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 23:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01846284D73
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E115A851;
	Mon, 19 Aug 2024 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vtjIWkUc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103CC15956E
	for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724102758; cv=none; b=TCDcnTJ8tizp2fUu85c0CpBKOPOf4w0Tm8XzTUveffkvQ2mJ6HvIBF7jPBW22W9gfnKYqjJKkdaz8tDSfJVvddUe4ifZRkeA6xez5mfXZKEDHKS9r30EcZPjQRg+8hAo5gW5e1RXnnK0u9/fwdXw69mJLsVdZNRoyYXG0laVrdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724102758; c=relaxed/simple;
	bh=4gcwvsbDbylR6ALk3uIyPQcaqwI4eJ9JCByYJw9qjak=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cHYa2NpggJMlBLsJD/cnJOfRyXjngzE5cknXhLhNfbiFGJcOcxiXTfyFSS+/VmjL1NpqM1nHMgiXJCszLyRcfLVkh9tv7asQJyBMPakah6Cts/WOJoi8asgZYjqgC3VqBiORP7Boglxw1z6CUUJf9x3dwrYdcDFNG9I8AM+Mca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vtjIWkUc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-201fbd0d7c2so29212515ad.0
        for <linux-integrity@vger.kernel.org>; Mon, 19 Aug 2024 14:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724102756; x=1724707556; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gcwvsbDbylR6ALk3uIyPQcaqwI4eJ9JCByYJw9qjak=;
        b=vtjIWkUcJxe5iJ8XGff3u3vuAaMB6UHXFFqq47j6dVtsCkRAAPfimY0eKVDAgcFVQu
         2o14GNCO1OED3kF/qbpxJCl4T8a4v9m2aJQhp3Sv2yqKUPGf7YwmYJ3rRQHQelBR2lwV
         CMhY4JE9902JunmGsYy8N1s6ZDzdPIEGIs/56z/SmC7WNS/q6sCkJMFDFoAFplEBUsVv
         fpYnUHJnXnOCO2dVbkGEAItYX8u3Ac3VNqUXshpTrb5/7B83I6w/W5+j08p171XNnQCh
         2I7wDgr7xVNUhLOBKqiKzmim8RQ0mRLO+hroVxSy4lFfMpnuAX7M9fh8k4TIPBo1/G2y
         +Kaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724102756; x=1724707556;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gcwvsbDbylR6ALk3uIyPQcaqwI4eJ9JCByYJw9qjak=;
        b=lETh9hzwA490f5KFYuuD9bWtP9oZKIGVu/Gm+1j4VbnqXR7oQJkrbzo5daEIDTUykQ
         +YZ4CFc548VjEnVOY2WlZMFYdxKcE1kyB49QwCZCaUHlVChnABnY048ERTwg09TG680f
         QZLGSPIKMT9xplQSKDyr6YdPMDfiIHZJbY9R2PfTjFn+aTgu5chnZwvSx3QnNXiToNdy
         xlMSOFJc4KiBU/Ig8cmz2e02vHjb9sUsCzkwU0XplXqFjW0qE+5+Wm3ECeFVeadWbPNP
         hZfnxZXcPuXON5Qlo4PIWIrs9Kj0orzjpjN05Qoj2iFI7Ihm6u90O/TQfD77A8BAhV4n
         kGhA==
X-Forwarded-Encrypted: i=1; AJvYcCVxN38g3PopAHMqGK/PXvEHigiVf88+MQ9VNqQFALP7I+xIu7n/dNHZs4pvw6R/R/QOEtajBYGkxQi2MvMhM0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoo+HAkLg3zgYJP5sean8TvIXxQBqjUDCO+CurlZIJXvYItvC
	ARKDczoh9s8RWpEJFf50RdwOp5eFi0rI702Aj5pCPyXwj/tTFip1LNvx77ajwA==
X-Google-Smtp-Source: AGHT+IFQHjn7opTqOCiNaxJXDmg60fElwtXeF7Mqy68b4YAgsiN5PqrB96o0Hinj5H+icTZoy+OWwg==
X-Received: by 2002:a17:902:f644:b0:202:51ca:9831 with SMTP id d9443c01a7336-20251ca9af9mr36829615ad.49.1724102755813;
        Mon, 19 Aug 2024 14:25:55 -0700 (PDT)
Received: from smtpclient.apple ([2620:0:1008:1:a1c9:254c:e95d:4199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375acasm66870965ad.161.2024.08.19.14.25.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2024 14:25:55 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
From: Qinkun Bao <qinkun@google.com>
In-Reply-To: <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
Date: Mon, 19 Aug 2024 14:25:15 -0700
Cc: Dan Williams <dan.j.williams@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Yao, Jiewen" <jiewen.yao@intel.com>,
 "Xing, Cedric" <cedric.xing@intel.com>,
 biao.lu@intel.com,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-coco@lists.linux.dev,
 linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vishal Annapurve <vannapurve@google.com>,
 Chong Cai <chongc@google.com>,
 Dan Middleton <dan.middleton@intel.com>,
 Alex Crisan <alex.crisan@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6DEAEC08-420C-46A9-8877-EBF60331A931@google.com>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <c17a31e4fb30f5f9d4a337e5bd8d54cc6f99eef7.camel@HansenPartnership.com>
To: Samuel Ortiz <sameo@rivosinc.com>
X-Mailer: Apple Mail (2.3776.700.51)

A gentle ping on this email thread. We have tested the patch series [1] =
and will release a product based on the patch series.=20

If the patch series can not get upstreamed, the whole confidential =
computing community can not have a way to measure the workload with =
RTMRs. Without the patch, RTMR3 is completely unused. The patch works =
perfectly for our usage case (Like the existing TPM ABI, the raw =
measurement is taken instead of recording the log entry.). Assuming RTMR =
serves as an alternative to TPM-based measurement, migrating existing =
software to the RTMR could be greatly simplified by developing an ABI =
that resembles the TPM.

I don=E2=80=99t object to having an ABI to take the log entry. For our =
usage case, we use the Canonical event log [2] to measure the workload. =
I do think that we should NOT block the patch series for several months =
to solve an issue that TPM can not solve.=20

Link:
[1] =
https://lore.kernel.org/lkml/20240128212532.2754325-1-sameo@rivosinc.com/
[2] =
https://trustedcomputinggroup.org/resource/canonical-event-log-format/

