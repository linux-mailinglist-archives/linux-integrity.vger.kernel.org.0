Return-Path: <linux-integrity+bounces-7911-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E44BCB5893
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 11:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003EF30198AA
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 10:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AAA2FF668;
	Thu, 11 Dec 2025 10:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gy4M2ztW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD33F3043A4
	for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765449469; cv=none; b=r6tdEBARettikuEj0FeB5ur4FSCbFo3tpdPieBB6uRU4mCSq0U+L5FBtQvCIeUBIcYl65Kql2K1wPJbSZn79WMJvxLZaaQ6dlkpG9DPDFd2ydBFtUSPmBJkFnTEWEXcwRARPJuxeQJsF3gIAH33iKAtlE3RFjLcKcEQyYEUscLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765449469; c=relaxed/simple;
	bh=9BRTH/FEGnS97KG3LM0lBBvG1ySlWbwu0HJaW9O0rNw=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=TZ7evXPbe5fqrp30MQOJbW9298A19cfMEO5lf4TKq3Quyjp7Dv3HBGhRci0XRu85gwLPmeepFwh1NnT32grcuqTvjoZw/vnEredtRF+s3UOQv0jecTkoAsWyTwrdaikuQTtXQG+02WOjsvkRroWKyBsm/nCe7vQngyv7doGLsEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gy4M2ztW; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-37902f130e1so5583521fa.1
        for <linux-integrity@vger.kernel.org>; Thu, 11 Dec 2025 02:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765449463; x=1766054263; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BRTH/FEGnS97KG3LM0lBBvG1ySlWbwu0HJaW9O0rNw=;
        b=gy4M2ztWJpmEaBDVuRlSu3B9OtgZrgaYxYfQt71AAhU/GcQzBdY7uonFOOISfBE126
         2u42j6dwkrFccuwjtftgHAxMRX5K4+GKSOBmjSPr/dr2cm7id8UWR+HmHlLvLKoghDoF
         hVIM7A0nzA8uWxS2WpDIk7/CsBBrj4DH9CtNMBxg/1YlRe2Dju2kHCTPAQI9h2ANGfRr
         YIyqhcc4uVilFlNo/IIw7bnOmCcNCJjzwkGo9e7QC09ltvTKQqNrQ+wbYTJ5xRVHxzpW
         iuvTcsnh1LIcuj/Ryme3Na5DD1EUazH0+ExV+2LdMNQzhZY0hVh6Cho1aMoKcuxHBaab
         TZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765449463; x=1766054263;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9BRTH/FEGnS97KG3LM0lBBvG1ySlWbwu0HJaW9O0rNw=;
        b=MO+uiSUZvz9tuu8XRZY5XOl2VWH0nvVYnA6ifOVLYHCE03otT6Y85EY9sXb5pyYCTA
         Hw/OM5gmXORDn7MMa3IzF3MV1Z1+XbaS9BkCQiAcZk0FSXRL2GwC/gwBQoJuRGI9Mby2
         Z3sgWaqKJks2haCL9x25FO4vKLwfaUJ8yjUmUPjtVQv2LXEj7eEnzuaJ3yiZGYg0sFAn
         II+JLiRCdQd/6YSE4NyrhEgPO4rI25SXQ8b2CJPO0oOcUgZbe3/omKaJoCssCphYN5VO
         xBDVraNImtZ2gzujKjqdXhzKUolV9E669J6EetK2SmDuz8NSuxribLEZLblvPSGKbxXK
         Rr1w==
X-Forwarded-Encrypted: i=1; AJvYcCXMJ3w9rUMRW270yfje7/IcrAi3b+qMsUQaZZXlhTEH05UnEMGlJUTjOZvK9OVs5tHw3IhX33mKsyUrbkyNIoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlJ2FxcaoEvUYqKTV8qJdFVZVK0nrGmYf6jdgmQhdrz3A/7kTA
	+Hd2q9kcxzqMES4HLsWgVi2+6a47/bRX1AI1dubr6Xe3pkg3MLRdKxNmLwrsSxzNJUg=
X-Gm-Gg: AY/fxX7P994aEhiTfCAuFi7yg0fWSx6oTJYPMRhyyZ6rhlaCUWkfHs78z3pmK/IUhiU
	Z7HkuTKkZMVfz5J/xf/w1jLGkuFhqsp6von9Oa35pDaWJz2s3yXOZic5D7UORYEA8DRCmEbTLal
	LBjt/YNdMCAILF5HMVhJPSFu2pRevObRlVGdsW509fgwZKGjYZJZOH+K9BzhTpx+eeb0jenp7gk
	JJw27ZTyP+iwU4jkCQORYq3k05+d/SVaBfwRTiDDU5tr7mTS+vpkrbiez0F72QPTj330HqQxavq
	QbSZWNuiUYGsE+vNgXLwfO68wJfY6o1csf9Dt0fUXUkyKc4NKXuMqkvSIrpAQl2HN+J5Bo76Mod
	kraMp7K6ZsP/vRMhPEtyL2XSLcVnCN9PHWDA4uahcDbRHnFPLk3HylTaUk2BKRcKdVMlx2P6Jx5
	blA9suWcZ2LExYK2/Try0=
X-Google-Smtp-Source: AGHT+IERqS1L6ci7q8dGntRfw2/ZItR2qtmAlqrQG8XSEGr8iPup2BGl+AX1ZFkBRb6+fnmg6Y4WXQ==
X-Received: by 2002:a05:6512:33d6:b0:595:81e7:3daa with SMTP id 2adb3069b0e04-598ee52e8c5mr2220693e87.27.1765449463194;
        Thu, 11 Dec 2025 02:37:43 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f2fa75efsm748663e87.69.2025.12.11.02.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Dec 2025 02:37:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Dec 2025 11:37:41 +0100
Message-Id: <DEVBLPYYQNMS.3IOZO4CG4IAYU@suse.com>
From: "Andrea Cervesato" <andrea.cervesato@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
Cc: <selinux@vger.kernel.org>, <linux-integrity@vger.kernel.org>
Subject: Re: [LTP] [PATCH v4 0/4] tst_runas.c, ima_{conditionals,
 measurements}.sh enhancements
X-Mailer: aerc 0.18.2
References: <20251209185557.20598-1-pvorel@suse.cz>
In-Reply-To: <20251209185557.20598-1-pvorel@suse.cz>

Hi Petr,

thanks for adding this tool. We will probably need to update
documentation as well after this patch will be merged.

--=20
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


