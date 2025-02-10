Return-Path: <linux-integrity+bounces-4771-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F244A2FB7F
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 22:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A1C43A4489
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2025 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F4A1F754E;
	Mon, 10 Feb 2025 21:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=namei.org header.i=@namei.org header.b="ZyGYKtxX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.namei.org (namei.org [65.99.196.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B12F1F4611;
	Mon, 10 Feb 2025 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.99.196.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739221927; cv=none; b=VAG5N2IEH5mBBj5RWBbp2Y2dmnYg/ifmAiiggy8r0EfXiTySGR9EQAWV5aBgrvqmQCVXN+osnRtwEd2Ks0G9hXivGE/rgMdM3mW5D/cpV/iu1pZHnqho1Q8hv3nXLDh08No+9PRy5QtRLFQn71OPdWOo5DWjW5D13ry44HU+EUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739221927; c=relaxed/simple;
	bh=UBCe9p8sj/JNzRoVoJtwDN+Lk8MaBoj1Z2Y1UU8mEbI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=BKhwXwFG0OLan0KTy/a7dZVyq+9LfSClAodj1rPZZBiIHj53WbaSGYFF54jSROIT0cr4IVi8vUrQpHk+1rzX8FgCl2zcsrhr7BxBGjL/av/AeeT7h6vI4772nVTEAwvi4nmolVzpBDA3KtLFtm6kN0IRlRWSVoyO8jA53unoBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org; spf=pass smtp.mailfrom=namei.org; dkim=pass (1024-bit key) header.d=namei.org header.i=@namei.org header.b=ZyGYKtxX; arc=none smtp.client-ip=65.99.196.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=namei.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=namei.org
Received: from localhost (localhost [127.0.0.1])
	by mail.namei.org (Postfix) with ESMTPS id 6B6F6C9;
	Mon, 10 Feb 2025 21:03:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 6B6F6C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
	t=1739221382; bh=h3x3P3W8K+9OlCaN6BjlODAjJulvwo/lejT6q6M/Los=;
	h=Date:From:To:cc:Subject:From;
	b=ZyGYKtxXADc7f/1Rh/aC10cIngjwj16ltm/q3MfCt8DpEmDiqR+PtyGUWVSR0kvRz
	 WXzo9JxxhLYZGiDmsn7pRtZqTKtOIt2S8lftxNWQi+yDOhiUqDdhK6GX2dF3J+WjHA
	 woDtfm+66JQFoacJ2svGVd5rL0o5ADlT7Wh/OkFs=
Date: Mon, 10 Feb 2025 13:03:02 -0800 (PST)
From: James Morris <jmorris@namei.org>
To: linux-security-module@vger.kernel.org
cc: Linux Security Summit Program Committee <lss-pc@lists.linuxfoundation.org>, 
    linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, 
    linux-integrity@vger.kernel.org, lwn@lwn.net
Subject: [Announce] Linux Security Summit North America 2025 CfP
Message-ID: <35b17495-427f-549f-6e46-619c56545b34@namei.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="1665246916-1759655948-1739221181=:1918214"
Content-ID: <1eebfa2-83a-d771-38e3-a986f4542214@namei.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1665246916-1759655948-1739221181=:1918214
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <30fe1e86-d93-3681-6dff-9a32f4d6df6@namei.org>

The Call for Participation for the 2025 Linux Security Summit North 
America (LSS-NA) is now open.

LSS-NA 2025 is a technical forum for collaboration between Linux 
developers, researchers, and end-users. Its primary aim is to foster 
community efforts in deeply analyzing and solving Linux operating system 
security challenges, including those in the Linux kernel. Presentations 
are expected to focus deeply on new or improved technology and how it 
advances the state of practice for addressing these challenges.

Key dates:

    - CFP Closes:  Monday, March 10 at 11:59 PM MDT / 10:59 PM PDT
    - CFP Notifications: Monday, March 31
    - Schedule Announcement: Wednesday, April 2
    - Presentation Slide Due Date: Tuesday, June 24
    - Event Dates: Thursday, June 26 – Friday, June 27

Location: Denver, Colorado, USA (co-located with OSS).

Full details may be found here: 
https://events.linuxfoundation.org/linux-security-summit-north-america/

Follow LSS event updates here:
https://social.kernel.org/LinuxSecSummit



-- 
James Morris
<jmorris@namei.org>
--1665246916-1759655948-1739221181=:1918214--

