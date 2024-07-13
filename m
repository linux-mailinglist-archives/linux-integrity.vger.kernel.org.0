Return-Path: <linux-integrity+bounces-3106-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30E93080C
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Jul 2024 01:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A3E91F21768
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jul 2024 23:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4261448DC;
	Sat, 13 Jul 2024 23:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UwR2zisj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921DE44C7B
	for <linux-integrity@vger.kernel.org>; Sat, 13 Jul 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720913348; cv=none; b=Cvq3fFpoEWfhKBeizoOky19ObRZUbbWjGD5wUdxAdho25Ksbbm9v4H9retQA8tLUX9lxOXGpXwFbTA7cOuzcWIvjCG1sDGWWHg8dmlS8uDLjeY+v6SVkUWwVSo68DVx+M506im0xmPKBTCue2ykWbM79LjEfeQ+bVmQrGNlzDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720913348; c=relaxed/simple;
	bh=M/AvsivzDqTnYbkqcOyzYWQpJBTHdgFX/+yrR5IViz4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nDlowgCYDZ1KzS6Ton36SpudyzWGXRUG96SUTP1/qBj+XUHWPM09D++PlE46fiD1v7C4BjbHwFIN+9ToGA6/jXWeCjT0r1dytMGbwYVPM5gzyPQep844lfuK/aQjK/L6fiPHAl/3/LGGjGAgRiyrWzRPI2H/QWKTyBXhhpNEWK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UwR2zisj; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-70368b53cc0so1595677a34.1
        for <linux-integrity@vger.kernel.org>; Sat, 13 Jul 2024 16:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720913345; x=1721518145; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVxraW28RA2WdzslZaE8dPXH80KC61WA5pdsVo3++fk=;
        b=UwR2zisjiocmLsJtq9tvuN5LCYVcD6r8/O2HMwj241wnYLXymQoLS8bDCw+ZuRDen9
         Z1OonBG/GEnYgDMTC1/E7m7XjbAYoEeMlUnpop6aa143W4JX2HP3RFsHOkaHRy88xpf2
         hyOpr75/CUu5D/PjLKR0EldmT87NPs97snqUQcRmnHCUTXDrm+jL9MmoqWp+B6akuTBS
         NBv671jgqSHkfnlFspBjRrBz1MZ0b3xY+D0+FZqUcDmdSvtTk21T3XSfi8cxsirqa7nG
         qVt3EojDpkr8WhhAfUFcpQ7RD9WP/PGY0uXutOdQBuSh0Fy7clDmMBfJeWXEqN71+bT2
         /XsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720913345; x=1721518145;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVxraW28RA2WdzslZaE8dPXH80KC61WA5pdsVo3++fk=;
        b=ZbeabkPl0QYb4zH2lXIXrbziOfMMbyN75EAIRO95VEq6wneMdEqIkn1ERT0TfH5LQh
         M7neDmHap2Fh82tFn9UL86Vht5Sg6p+EDT4OiGAr8k3EG3Hvwsqx19fZ3GDIlY5cahta
         Ksg3K3PJTh+YdRTuwiSn9yD8EkuTbjaARxlu3+EUMdK+2hKauXOmzgIS8DZsJQofM4e8
         gaP2KjnTdvVUPA7epsG8v2XN3Kj9IA4xpCSHrRrD9EZY5xwSc48MlE+Lp6lyUmGySV4a
         3AfryftgACTIDMKoKjkdRHyz0m06UQCN0oNX94Ov1pYHXc7KD+hdwXHqwIhDKESB6wA9
         IdVA==
X-Gm-Message-State: AOJu0Yz9reu8sd2BZCnaN4Bf1pVWK64oP19wijM/ObSOQ4DNZMbVBG47
	OqXxV5PFpQyF8/FN//gNCCOlhV+djgfY7oVowjHkCtEjbYAM3dU6W0eYY4V4rF3QHmxw4zNwRxv
	W
X-Google-Smtp-Source: AGHT+IHwlwNcqFJec1lUtwXJgCvu/DND3dE3BswO01Hd2/uENUaWlfY/fcJcUSgZpOfyBh5zm/D+sQ==
X-Received: by 2002:a05:6830:21a:b0:703:5f4d:a758 with SMTP id 46e09a7af769-70375a08790mr17149467a34.13.1720913345612;
        Sat, 13 Jul 2024 16:29:05 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1cb1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708c0c78623sm466757a34.28.2024.07.13.16.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 16:29:04 -0700 (PDT)
Date: Sat, 13 Jul 2024 18:29:02 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org
Subject: [bug report] tpm: Address !chip->auth in
 tpm_buf_append_hmac_session*()
Message-ID: <3b1755a9-b12f-42fc-b26d-de2fe4e13ec2@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jarkko Sakkinen,

This is a semi-automatic email about new static checker warnings.

Commit 7ca110f2679b ("tpm: Address !chip->auth in
tpm_buf_append_hmac_session*()") from Jul 3, 2024, leads to the
following Smatch complaint:

    drivers/char/tpm/tpm2-sessions.c:755 tpm_buf_check_hmac_response()
    warn: variable dereferenced before check 'auth' (see line 752)

drivers/char/tpm/tpm2-sessions.c
   751		u16 tag = be16_to_cpu(head->tag);
   752		u32 cc = be32_to_cpu(auth->ordinal);
                                     ^^^^^^^^^^^^^
The existing code had an unchecked dereference

   753		int parm_len, len, i, handles;
   754	
   755		if (!auth)
                    ^^^^^
The patch adds a NULL check

   756			return rc;
   757	

regards,
dan carpenter

