Return-Path: <linux-integrity+bounces-7378-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D049BBDE58
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 13:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 72E3B4E17A6
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D5320FA9C;
	Mon,  6 Oct 2025 11:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TxwGsm0f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2332427461
	for <linux-integrity@vger.kernel.org>; Mon,  6 Oct 2025 11:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759750817; cv=none; b=HmxuvlFEyDHe7dHZhdM1OYQH66pSIKTFy9fa2YK4xZ4vlTucCgJHugigJmYnbs5I4bibmGxmck9cuVB4w3L00i/AMfJZI+a9dEE/5dnA3kq9bn66Ux8QJe/TZRWDtIFS3ash9+GQ4jpTP67eZ9nmSU4xNaI+tOeF/IQ1tnLGYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759750817; c=relaxed/simple;
	bh=R49g8QY1xucroMMOEO6d4D1yGD2g8xwBSsVF05J/x5w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Zykn5BeDoNHDhcsHev6iR0u7Zv6BUlpUZ94t+1aVtEEMdXvaBX1rXZmtYTyYtB4ELREamuZ6wmtoMy0b5SgSc+6wJ6ASE4DGwZv/hH3s8FdzDmZYsJE8s/d3C4l1Qedv6sVGtLHUiESIlRbveLdUnXZjDUvakBH2AIUoqvfx7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TxwGsm0f; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so3294075f8f.0
        for <linux-integrity@vger.kernel.org>; Mon, 06 Oct 2025 04:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759750813; x=1760355613; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R49g8QY1xucroMMOEO6d4D1yGD2g8xwBSsVF05J/x5w=;
        b=TxwGsm0fUITrCeDc/tqDPNMc+RsDJQeI3kPfW3tv6uUNXnpybtUiuC0tgCypBJvy/w
         /iDWmhgzzXm4OHIvAq7wqN8f3Rj6z0MGt6JzpJAcjOykxGxEq4ier7751sCaYNWPd6OS
         BXNxHnTsLwpD9M3//REZ9Gc1qRXRUiv9COo0xc1c1f2iiOvcSlSbVaJv3QVLfq187IIz
         u6Dyl1Sb/bTOZfPqtpJLKRO0ykvLXpiKYGHo7rCRMQcvfZZdEVyEooRyHbtRhJLOXvOZ
         Rig3GIt8UI2tAnYjAJHDH4fO0PXKeCAMf/YRmM6UTTpklTQwAGAgC1oaEV42T/U1WXmc
         7h+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759750813; x=1760355613;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R49g8QY1xucroMMOEO6d4D1yGD2g8xwBSsVF05J/x5w=;
        b=TF9d10uQmCHuhB6Qzab4rbS1PXy1XPQo2k5MQicHe2C0u38KpbVsI3Z9M2I98sCbua
         9Im5CduyXTDJIVN+BII/QsUMzjA3PdT+uOc+fyYfZfdEwKzjhHaZVAC4HVhY8RwmAvwJ
         rz2GmjQ8zbRe7DjqWfMz0LidMx3cg6mBTeUA+/8iSssZeVlnNgita+FU9fzvWDwhzDKG
         nXDD8begsPpT3mvGVabS7cOxm9GnOo5tesPTcIoLL0ft0AWjnyPSbSXMa0KeVbAa365x
         jHElARJ+FCNF5cVpqAtcw/6VqkElreVT3KU8JkUkTvvMsSqpnGQE9ccMZvQKNtu9jbty
         IswQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHzK1RQndxmculooua3QKDAnH55en8EW/mb4kExAL3P/98fkID9GaMKKoRi6mFiE4XvGCmb7BM2pDw5GJ7IWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyas93cudoD6LmOyoSuCSaTr18KWuVqoKWpHwyMoTfaezV+ZCWt
	jYJYYEKYgbRB4QemTt7zZnNapWNDigTHvgMhBDV5qGq3IRdwphpUvzqqJthLFT0e5QyL/+e8jmU
	MVu66kSg=
X-Gm-Gg: ASbGncvP/jKiUF4Z+ufHFT2UXv5mZN0fVzn3UMw9L5KR+zq92AmS2bYToJCd8r2pW+b
	DUl6AmVTRYX0khy5M7HNs4kD63OzifjhPnvLhYMEhwfT58p/tthav+tetQ3v0oGWfXqUaWUCpKD
	kzM1SXdq5vtqjhIee+4rMYCO55B1q4212xzvBtdk38gkpa41twZ7xelTd4zX57jvJX/zS4fVrcq
	KJEKMNjZT0OfOcKdIurErcQI/ZJvMTdOutIpSj0xPneW1iBWeqRRott/wpQEtyvkSLR65bja81E
	l2ZzSHOX5sERA7W06Pj8umct3enlKtuA04tku5pMJM1berwGV4TxP/YmlUj3zV9TW/ZcVTvWn7S
	iB3uBSrtsXEqwFntLzI0itmjEbynOfoD0XsAYWHip1fri239wkSJcDgsf1qhEj9Hfp68=
X-Google-Smtp-Source: AGHT+IGUdcRuthm63D6/0iEkuYfLsSiFORtk/oTjNlASzFIuO8XZqZZ89Ep3hHIl0WerkJOQsS0n9g==
X-Received: by 2002:a05:6000:2407:b0:3e4:5717:368e with SMTP id ffacd0b85a97d-4256712a5d1mr7683492f8f.2.1759750813202;
        Mon, 06 Oct 2025 04:40:13 -0700 (PDT)
Received: from localhost ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bdf533b8sm122938096d6.50.2025.10.06.04.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 04:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Oct 2025 13:40:09 +0200
Message-Id: <DDB7LLBEXIQM.2KSWEVEFU0TVS@suse.com>
Subject: Re: [LTP] [PATCH 2/4] ima_conditionals.sh: Split test by request
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.com>
Cc: <ltp@lists.linux.it>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20251002083701.315334-1-pvorel@suse.cz>
 <20251002083701.315334-3-pvorel@suse.cz>
 <DDB27F9FQ4B3.11FGF9PVV0DAE@suse.com> <20251006112136.GA82874@pevik>
In-Reply-To: <20251006112136.GA82874@pevik>

> verify_measurement() writes into /sys/kernel/security/ima/policy which on
> kernels without CONFIG_IMA_WRITE_POLICY requires SUT reboot. Because LTP =
does
> not support any reboot, this needs to be handled after test finishes. Tha=
t's why
> I separated the tests. This helps to cover more than the first test case =
out of
> four.

Now I see, this is clearly a corner case given by LTP limitations. I
think we should probably start to think about reboot flag then. Once the
PR for the new SUT will be implemented in kirk, it's time to work on
this.

--=20
Andrea Cervesato
andrea.cervesato@suse.com


