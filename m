Return-Path: <linux-integrity+bounces-3404-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680EA9603BF
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2024 09:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FB32807AA
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Aug 2024 07:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361A1157468;
	Tue, 27 Aug 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="K8w3G51h"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5962013E41D
	for <linux-integrity@vger.kernel.org>; Tue, 27 Aug 2024 07:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745514; cv=none; b=GBoRaJQyVHc29zziBLyAHoIAIujTjq97obEn62lZbkg5OuqLKshhkP3bSN3iDeEVhh72oUeridd3nRaY3FZXgsiCPeqMNaQ/fwsnJn0gn7plmKOSfwvipXvrjO+4/zDRWK6WP1LXQ2xlAB2nJTXo23fgjm8pnyRwgH3z6HlfYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745514; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=blYvLBt2xsjDIUAIr5gfEH12d2Dw6SgPlG3g7xq2NU6XcLWWWGcnA2/oZQ5Ayze5w/BCDyiFtsPi+OEQU73C/Ua+v9daQE7eAxaRKUoPQcchYnNVkfeg2MhXapwc3u23BdS3XTNzYA3XkACbEIaNK/myM1iZzxzsjbZVnh3H0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=K8w3G51h; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id 32F1A27477; Tue, 27 Aug 2024 09:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1724745427;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=K8w3G51hAvIO8C030OStR9FJ/WabmAmhcb/v4/v50zmWQuTe2MFZ0nAbLYp8sSngt
	 btHnMOiuZeihQ51m4gHKH2ygwcDmgrhSlNeDi6k0PXYEIfIzcpxuc29mHGEdoIqj0a
	 DMypPlCI04jZcUvM314BjO0j4wlNDsbWKlxoI6YyW52YYo2gkl7jrpXkvVrQFMjEFo
	 KZD0KjnFDGAbbiMMKg+tgjnYxk1OlAkooUqhzFrrYVJg0DQ4QyGuHrnC11kHg+MsMZ
	 ZC2U6J41D935RW8AP9KrYc1WTBORyL4tGd6zSNjxm/tm7GiK7JO8zX8gkUZOYnWhOb
	 HzXUGrbCw4EcA==
Received: by mail.tradeharmony.pl for <linux-integrity@vger.kernel.org>; Tue, 27 Aug 2024 07:55:59 GMT
Message-ID: <20240827084500-0.1.8a.2xj9n.0.7b87n6mh4g@tradeharmony.pl>
Date: Tue, 27 Aug 2024 07:55:59 GMT
From: "Karol Michun" <karol.michun@tradeharmony.pl>
To: <linux-integrity@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.tradeharmony.pl
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Karol Michun

