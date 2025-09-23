Return-Path: <linux-integrity+bounces-7253-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C4B97EBB
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 02:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0915189F945
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Sep 2025 00:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC51A83ED;
	Wed, 24 Sep 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="SY4sB04j"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674D19D071
	for <linux-integrity@vger.kernel.org>; Wed, 24 Sep 2025 00:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674621; cv=pass; b=tFxJVVUECwTOFY3IpNrP77Wh2raxV3H0Jnz7hib+xhL3ahKTUG82mlvzZ1u8U3TPvzQnf9UjIHxi+s+E8AzRXS7nNvKoGWzbLy3O3BSyQM+LHjC/4P0UwMpn6adRp9a88kyWcqTHvRo5O4jdGQ4CZMR1hVZ3vXNUIWIFPzEOejU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674621; c=relaxed/simple;
	bh=2/BE5OU2kT+kOMRwHlcTajUW4jisCQFGreiTS6XT5Os=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=MLwS+r1H5gf+2KG7C5zongqfZvLrZ/4jSK73Urm2yTmYCf0m8aCMGY8qqeVNzH/GZ1N4SkAzWOLjpgi09GRz+PAJYmz8rzTPX/swamduUwMBxNtPdl/eQwhkKuICTHSHmKtu8NI0U3EfZyezTGYQA9VPm7/xTeI8EglIeXkgvV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=SY4sB04j; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674619; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=eRU9HNGftBBwRbhcprZ6VaUxBdgE7xh2hWntk+VHY35V41YcNyTFKMFwPFZjEhHpSqSFYF3tPjQ0CEPQ4pRQtboz5+BnPvLl7sjYdPcfeQ9WfCZHxCxLe7QI2jdrHRIYI4+E1+GKKXL/vLgmrvOE2Ht2tB0o0gUcm5Y1yZUU2EQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674619; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=2/BE5OU2kT+kOMRwHlcTajUW4jisCQFGreiTS6XT5Os=; 
	b=f9OrFqvqiiJg3Y6NCarLywzEECTvdmgduTSh5E0ISj4VDz9wfoJbBjzONYzJHV/ibmASdgsW/1CAZ20mzTEUxgAG/9ZZFaetiY8CsvP6OQJeHTgqrOXUT8sBInt3qSEC/JSu2t55xAm/UTGwWLljiwkpGNip4eGG8yu/Tm7yAAo=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a7c2330-98d8-11f0-8217-5254007ea3ec_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671652887737.7049341654856;
	Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=SY4sB04jHEB6tS0DU5BYtvWrKUAkN6Zc8LLnKOtrC4E0eF3BZ0wU1+5bW53nbrKl49kjaxmFv1gnpXUjrCDk2jg3MO66EhJzPcoXOdzH9b/9Bp1ItuwNkIsbSrMJXi+NqtWFE1dcadcud9Ylh9jx2RIDbN+Y609OqteQQbIOaHA=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=2/BE5OU2kT+kOMRwHlcTajUW4jisCQFGreiTS6XT5Os=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:12 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-integrity@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a7c2330-98d8-11f0-8217-5254007ea3ec.19978ffc4e3@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a7c2330-98d8-11f0-8217-5254007ea3ec.19978ffc4e3
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a7c2330-98d8-11f0-8217-5254007ea3ec.19978ffc4e3
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a7c2330-98d8-11f0-8217-5254007ea3ec.19978ffc4e3
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a7c2330-98d8-11f0-8217-5254007ea3ec.19978ffc4e3
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a7c2330-98d8-11f0-8217-5254007ea3ec.19978ffc4e3@zeptomail.com>
X-ZohoMailClient: External

To: linux-integrity@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

