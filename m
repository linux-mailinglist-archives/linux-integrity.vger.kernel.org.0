Return-Path: <linux-integrity+bounces-4191-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FA499D84DE
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 12:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB706B2AF8C
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Nov 2024 11:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67011191F7E;
	Mon, 25 Nov 2024 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JwO+2VxU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D69185949
	for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534709; cv=none; b=WApo0O1QrsqaRfxTws7NotnflaHteVKuaBrZxEXaRpOWhOd+mI7qnO1sln4YXgmPAy1Ia352gZAOPdopnntw+FFpoB0aBkqT03u69vUuxj1QeqDeKf0prRmGLosESoSBx2SxiGKpcpD8rkXxfBP+Rmj91utIjKfrNtZcvODQJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534709; c=relaxed/simple;
	bh=Tjn3ldWMlIelYgiZ7Kw3QDG8FrV0cu4HsyTDx+ujnLk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=moGi7WX+o2hKJq+ItshnnFD001uC81azKX/sIVvq3Ns199Z9Yuqp8rcfGpI+U5H+MnEiwlP2b2AHHisv6tT2xwN2efIwoYuDwOOypB0YJRmBqcgUMv1oaSts/pzztredvXZtOQGsNW5MMFWKVi2KTxpyJ9SeiYI4GfvBu4gJc0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JwO+2VxU; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e3882273bdfso4588962276.0
        for <linux-integrity@vger.kernel.org>; Mon, 25 Nov 2024 03:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1732534707; x=1733139507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tjn3ldWMlIelYgiZ7Kw3QDG8FrV0cu4HsyTDx+ujnLk=;
        b=JwO+2VxUbqIkXpuZOGmENVtL5DXSXkkmEMpLhsPt0UQl8fUkedPTSpYl93TxmANxS0
         W88QV6edqnCzUOLM0Spiu7qgKue2Ga8z6Z9mpGET026K1KfJQhRcTW1ikPOIK/Rr8dWc
         MCUZQXcXMRDSB/2WJQBomjYallyqdiXYmsAZvEk1LBXIz59w3xdBxw86u2pLXtYXG4mp
         k4XzAne+5etxGC+YOp+9VYQSNlcuc+lqCAVk2JV1f27fuNj9s2GN3naGiorH7CPUH67z
         6+2dlucuBLPz33STP5u4qKcavgt5CG+aoUkvpaMgkqJHG4Mo1Sk8kLiH5ezmDcufeR+F
         FLVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732534707; x=1733139507;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tjn3ldWMlIelYgiZ7Kw3QDG8FrV0cu4HsyTDx+ujnLk=;
        b=fMDrIuAhSkp5Ir8WrEsar7lLg50569XLlnDli6LmQvVYIiQQBGS0962dUFCZKbfs8u
         udgV3RK0YUQdy1Dz+CPQHPhenH7t+CJlGYkYBN8+44w1FKKFCQU3nxfSFwLK3/k1StSR
         usjdjT7O9Cqa1/rwoQDjz1/xHKN1N2KhppBzsfxOHLFAFbnpnUGfbfud1PxxfoCiZcNE
         ZsQRnh0Z8m8GLHjr2GOjMEke7kWip/byfT+L+mlkwAViwz6K9amOW+GXHyuINpvkdDcH
         8Sj9fQcr1WwrtxtWkh2zDaSQOaqLSaQvfjX4zWwOFR0C9SiEk1GlBz/HdH5BxTz4k8ry
         q+cQ==
X-Gm-Message-State: AOJu0YwpANNiVIhQ7LI+SQuEGIB9GPsGf3WqzDswT/5CjZR8LUga1lan
	NUlg3Erz2MJblVNobIziWV7sHOmALHjRvi8RK6BNDSqJU9nXyYbyaedl8uJHQbPra1hV0oyjKVS
	Tg2pZ28WkZs81J11vzY1uIvg+glj9umx9
X-Gm-Gg: ASbGncsXtFNnLJiFOawULhbomWQXnkJ/1jYvQG+jv0JHLWpp3AhZMWtRCn8ykZAWwjl
	LwHZg2hG28dcRWwR+aKRKS+u3GpcVIYFr
X-Google-Smtp-Source: AGHT+IH1dX/SWikUI3elaTZXCAMAb7JTS9vgX8BUYkuAaGo/xp+OvHG2j6di9+vVJ+Ntm9clGoe8HyJ4TyeYnzpTl1w=
X-Received: by 2002:a05:6902:2b91:b0:e38:7b9d:f27a with SMTP id
 3f1490d57ef6-e38f8ad731emr9709601276.9.1732534706851; Mon, 25 Nov 2024
 03:38:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date: Mon, 25 Nov 2024 12:38:16 +0100
Message-ID: <CAJ2a_DeUX9UdAYOo9OwG-yXSH1etKQZortPcyxfzG70K3N+g7g@mail.gmail.com>
Subject: ima: property parameter unused in ima_match_rules()
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, "M: Roberto Sassu" <roberto.sassu@huawei.com>, 
	"M: Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "R: Eric Snowberg" <eric.snowberg@oracle.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed that the `prop` parameter of `ima_match_rules()` is
currently unused (due to shadowing).
Is that by design or a mishap of the recent rework?

Related commits:

37f670a ("lsm: use lsm_prop in security_current_getsecid")
870b7fd ("lsm: use lsm_prop in security_audit_rule_match")
07f9d2c ("lsm: use lsm_prop in security_inode_getsecid")

