Return-Path: <linux-integrity+bounces-6019-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B87A9B568
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Apr 2025 19:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5454A48C2
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Apr 2025 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C939328F501;
	Thu, 24 Apr 2025 17:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b="bDnIMZMo"
X-Original-To: linux-integrity@vger.kernel.org
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39528EA59
	for <linux-integrity@vger.kernel.org>; Thu, 24 Apr 2025 17:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745516112; cv=none; b=UtDeJVsVArQbkWuO25WY+l9N2nkCLsvuRsw+jYagswGgxV5aVJFxQC1KmmtBtbUxRW/tDhnNbVK+8xhcnv1jbd3c4eMaFXIq7zT36Nv/7m1o75lXvF0QcOwj9MMvuozBPZZYl3wiyix6LhsGhBsegO6b7syFnZXYVHPzWmvQZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745516112; c=relaxed/simple;
	bh=TWikDJCxC5anGmCJOYswMamfffFmBWcw9siJc+NyXE0=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=DZTNpodFfWxoy6mbqQv/CSMTUO8zp0wbv1FJcuCsIJIR9sqyZtKcggZTwRkXAAac4g6BPhSIcs1k7zp6a6DW9MGzNseGhyA/EGk7+ox59bj/qMJ4LLV8LjlqOEO9MMFiDpJ8FoEpk76Uw3xbcrrAAeQ8YOljNUELIKo5U9/cee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com; spf=pass smtp.mailfrom=yandex.com; dkim=pass (1024-bit key) header.d=yandex.com header.i=@yandex.com header.b=bDnIMZMo; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.com
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id 11EA663D31
	for <linux-integrity@vger.kernel.org>; Thu, 24 Apr 2025 20:29:44 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:109b:0:640:c015:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 1753160B01
	for <linux-integrity@vger.kernel.org>; Thu, 24 Apr 2025 20:29:36 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GTUDlw1LkeA0-yUnQOKl0;
	Thu, 24 Apr 2025 20:29:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.com; s=mail;
	t=1745515775; bh=G2XEUa3Di0jO+rSRZsBwtsKjpQd3eFF+HyTMGgBJ9ok=;
	h=Subject:From:To:Date:Message-ID;
	b=bDnIMZMofb5Aqjcfwl90IPeWkgbRjPmAyMlIdz+py14Avo6+yW8H18hLmuTXb5buy
	 l1SjK/iFl+Lj0XGHFtXQFlTTtWzkNstlXVU5tsXEDVEGNub0CjR9Qk86FNmK0Ke1s6
	 F8Ki1hI8yuiECz9YQSXr/kxOdcJqSnl4vl7tWZQM=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.com
Message-ID: <5ac2d162-a9f2-44db-a2be-c69602d14b17@yandex.com>
Date: Thu, 24 Apr 2025 20:29:16 +0300
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
From: Lev Olshvang <levonshe@yandex.com>
Subject: evmctl hmac fails in setxattr even in version 1.6.2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi List,

I work on a ARM64 ubuntu 22 system, with installed
ima-evm-utils   1.1-0ubuntu2


I succedeed in implementing IMA and now I want to add EMV hmac 
functionality.

I booted kernel command line   "ima=on ima_appraise=log"

Then I made _evm keyring and added kmk and emv keys:
EVM_KR=`keyctl newring _evm @u`
keyctl add user kmk "$(dd if=/dev/urandom bs=1 count=32 2> /dev/null)" @u
keyctl add encrypted evm-key "new user:kmk 64" $EVM_KR
keyctl shows
  711205770 ----s-rv      0     0       \_ keyring: _ima
1066122475 --als--v      0     0       |   \_ asymmetric: mra: 
adm_signing key: 9375cf2445606beba28208741540ad1897d59051
  315058417 --alswrv      0     0       \_ keyring: _evm
  685369470 --alswrv      0     0       |   \_ encrypted: evm-key
   35009219 --alswrv      0     0       \_ user: kmk


But evmctl hmac command returns error:
evmctl hmac /etc/init.d/netconsole
setxattr failed: /etc/init.d/netconsole
errno: Operation not permitted (1)



I cloned ima-evmctl and compiled version 1.6.2 for x86_64, same ubuntu ,
I got same result
sudo /usr/local/bin/evmctl -d hmac --hmackey /etc/keys/plain.txt 
../IMA_EVM/DEMO
hash(sha256): 
0404a6cffb233ebd759555c7070d9985961bbd1d3007e7c8d9cba5e9c5c28496c51f
Reading to /etc/keys/plain.txt
generation: 3093355876
no xattr: security.selinux
no xattr: security.SMACK64
no xattr: security.apparmor
name: security.ima, size: 34
no xattr: security.capability
uuid: 069df3798ff14641a6e0f1db2b852380
hmac: 9df5db81cf089c22c4c128070c36827d7983284f
Setting EVM hmac xattr failed: ../IMA_EVM/DEMO  (errno: Operation not 
permitted)


It must be something trivial, please help


BR,

Lev


