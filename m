Return-Path: <linux-integrity+bounces-4761-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03404A2D908
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Feb 2025 22:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 079383A481A
	for <lists+linux-integrity@lfdr.de>; Sat,  8 Feb 2025 21:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3099C1F3BAF;
	Sat,  8 Feb 2025 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="tjULheJ9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D4F1F3B9E
	for <linux-integrity@vger.kernel.org>; Sat,  8 Feb 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739051660; cv=none; b=oXftjJYq12bnMkbAqshDi+FBf5ITYtrCydvCUhrGeyK7M7FG1RfYxh6XtutkS7UWjK7jKolLw8EggnAD8Q6KSjcSE/ZaltcIDMEltVrMuwkq8y6oFzXAHBNbMELRP6t/08HYSnkszgshZXkFh4SC5q7likfC0KgAdtTmfSPT+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739051660; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Njk2JBee15N7mbx8wKblzXyr0m9Ew2hM4TsV3d623SDnKl2bll612UlYZHWMHQSG2aQ+VBOjTgVsoDvfnAysioSlfmh8acact8AVpm2KzLeM5qIFXY/JmdIB/4zf6Ek+CULlSqIVsu6q5eaojUiYN5HhVJT7qyz0KEaOL5YzWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=tjULheJ9; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=tjULheJ92lWcWZk+2tpfU3JLxz
	l7snrKdHWna5QuoJrPcQWtlqBLatcdGx2f395LEShGe6IOLFyXqo5hhVvkIIEjiE1hzCs+CgYXww1
	xhA1K1dX/buGyCx4KPc1u5E2qITWJ0Ur4eBFZkxdqUaKWbw1GRXv8kplFMumeK8kXqpz2zJv0l7ni
	aKgGWJXvjw5Dk0nlm55k4K6X5L2B8GGr1eI7x5odsRtlY5i1Y8IG17zgmWCyM+ZsqvTFlakcxcorq
	ZpstzdiXOUpim4rO/IAHWgYZb41Lsnce0fBFWTvhtnyMOnZ5DrQlUGRqQK3eJNqBlrf+ON7lwjxw7
	BbCsv1XQ==;
Received: from [74.208.124.33] (port=59241 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1tgsmE-0002TI-2v
	for linux-integrity@vger.kernel.org;
	Sat, 08 Feb 2025 15:54:16 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-integrity@vger.kernel.org
Subject: Re: The business loan- 
Date: 08 Feb 2025 21:54:17 +0000
Message-ID: <20250208210541.2C67D8A8A2E654D3@truemaisha.co.tz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server-598995.kolorio.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - truemaisha.co.tz
X-Get-Message-Sender-Via: server-598995.kolorio.com: authenticated_id: chrispinerick@truemaisha.co.tz
X-Authenticated-Sender: server-598995.kolorio.com: chrispinerick@truemaisha.co.tz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

My name is David Song, at AA4 FS, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
David Song
Senior Broker

AA4 Financial Services
13 Wonersh Way, Cheam,
Sutton, Surrey, SM2 7LX
Email: dsong@aa4financialservice.com


