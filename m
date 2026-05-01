Return-Path: <linux-integrity+bounces-9402-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAX8EH8H9WkrHgIAu9opvQ
	(envelope-from <linux-integrity+bounces-9402-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 22:05:19 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5614AF638
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 22:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E211230071CD
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2026 20:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6457F36920F;
	Fri,  1 May 2026 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="a+kZ9Oey"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995034752B
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 20:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777665916; cv=pass; b=u+JQhJx2mHdotT6lCJBsr6Iomx4KOkGDwpU9a/NwXr0JYUA21Rp5guthNwPFk+Hjroe4USjG1gUAL9O0F3Oix6fUiLoQsZtJ6Wv8Y0t73w+x9626CE0S2/vly3/6HutRsvWCPEJYNs6eW3mKoBbsjFpaOfHYRpYTSVId5TBmRK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777665916; c=relaxed/simple;
	bh=gY+mAhSmIpD2I9WqF/BYsejoK4fEJ5K2M93MG69wVic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i9M3HAEAq8sQ6RQMBeSR1pC0uzd+sobEBkpR4KekSZI+w3W+fmypxiJ+zUUpEB66LoGfCitxVsuYXdFUdSiPAecFRBrVXhQXYtvMn/CJ4GZlvrwL1efEMW6MZDpsEh7FZEibe/j6WMJzFHFmseu+zxgxn5/WvDffHJ6PKcnrvMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=a+kZ9Oey; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso3740616a12.3
        for <linux-integrity@vger.kernel.org>; Fri, 01 May 2026 13:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777665913; cv=none;
        d=google.com; s=arc-20240605;
        b=RmZxZt26UgS3V5+XctN8aHghciCtNY7zm7NorQVvirBtH218IKpKkB61ESFuzmXPSz
         rGeYxjBLWzk+ht9TErwHgJ7jEwhbXxK2LPJXhhp3TpRXZaipyhhoaA+7pCSgWL2T1TCb
         fRgAUoRthNOYcHh82RAXQfHFkRcK5yx0ZEG7KN2uPMGQOmRS3nZP2g3p8epfvcU2eoKr
         RFFNHP1eRNqgAUj9u/goUNbvY9JEjrXgvcz3vuyD3WxJfUaq4zrVe9SFcwsb+865w+Pc
         S5g8koBUdd198jKNVEfV7tywaKmG8idweQQ8/GgxocVggmh5UANkWofDt8bAKWdWl2Ey
         UZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gY+mAhSmIpD2I9WqF/BYsejoK4fEJ5K2M93MG69wVic=;
        fh=eb/wqeAcs5+xLMK1J+gYL8nfC/NZbrMqtx8D5SsWFq8=;
        b=h4wFhu1U8e3jwrAuBlo27mfuaF6kB71gLJMHkaEwjplnqhKgP2Q3PKrGE9k6xfgYvx
         NMvnoMwrmdqGmpxnJK5gyMps24ZoakB5SHD8NhEe2G5tlNqqwV1m0rlPhPW1CYKA6vpQ
         aiinoBrBIYjlqdAKBgDfWH44y/CjYUCUcBe3MoNPO/kQ745lhcNycOomzH5SyECtfMKS
         tFZNp9RtFiGxnfO4oGae70kFH7tw5eNzZPZE6EwnLxP0gu5ogwQsXids6pVFNG3zkvbN
         uW5Wb9TucbTlC1exnebp/9BUFOagavvCXyOU33Fkhbq7tHlMn1tzBe/qRQKc6bZLr09Y
         BMlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1777665913; x=1778270713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gY+mAhSmIpD2I9WqF/BYsejoK4fEJ5K2M93MG69wVic=;
        b=a+kZ9Oey55FkRP0LtC2fBuNMjSbVr4QYsLFF4gVEx1FhbCXQtNN994IeFGWrgrzN5K
         QxCiwWNIxt+Qbn4NEy+lY4cFCs4brcAPTJFz4l8z8n5haJSpAXVo5W9QQsAEmNdOD2oN
         zJb0jNDUjXtvd6fSruZ6KsuAYFUT+lY6IgXam7gaHULr7SELZNtzCgvZpnH6JqYa31BA
         9kJjGrw29vR6U6Om/Oc1N4LEIMeXB81LHeb0y6jzvdMvug67LJ8qyIE604m+HiujJjKg
         oTqrQvA6PJa2G7bCv/gqjobY8f9bxSQULmNONipKRQHOv3RoNRVYbYD8sB9C+X0wd1vC
         j3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777665913; x=1778270713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gY+mAhSmIpD2I9WqF/BYsejoK4fEJ5K2M93MG69wVic=;
        b=AHj1hmYJBbWgUDbWGNOVN0N/SAPNKQpbuJePBaiZQVR//cnc0KozHg88jyxskfLmmS
         708LQ3pIrpUBv+O8Vy//LsLpeyIs8oWwyC6UjQc/Ask58vi8YIovdTKy/0BiBEuS3ykN
         ZVL/GhZNgaOC2EShwM0FXsQz4/xZYL05oQVlqPw7pu2ht0Hiu2BgFX0A6BSMt20Zza2D
         x5vnTw3OvEtSQGtpiO6KVz2ZlmFLgBrUrb917I62zTxWE75clZhbqOp1vabJ7xEtoI/Q
         xkj1YEMvcJ8+nQoYaxQmOmn9uf1HZ5j4T1+9kNINbLE5x8oIOABEVtCmrzoMdB+1wdBM
         296A==
X-Forwarded-Encrypted: i=1; AFNElJ+Ktt69byyPUD0MKoWUqACvMHiHd01ubjUsTVYQ9ArbNBFABiWYawZIXPYaACdkv6d5uq3g8fwIODN8X356NBo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx00oDmIkc1ZJvwR52Mtc+EIdm0YXIjSpkyi5en+wE6Rls6oo81
	gET41pjE2sAAk4CTBrWPNoXatGyhMLMZidF/0L1FO4XknoWg8QSqFPdYldaPJQFeeu24ghiDKIf
	GyBDupI+LWkKD7TxHHg9B1TG6dhxOeVM2AOkCn/J1
X-Gm-Gg: AeBDietElvhkMXj965g0akVtxbQas+oQkDUgZePJJTk6ECdoT81i/IEUTtnUju27Cn5
	VcPBS547yWF/qwooGlVnDXid4sR3RKl0/qJCSas7X9V5JrZLwGz85yaYB4GV7Vum7kok3kwHsoS
	0pybqfSX+gzzQWOtctwVn8N//jygCT+CflyTr3qJPbYED6dEtwzT9SQ7uclKP1GeBBDySUQTkLQ
	a+thZRlKCJrWblbIo2OpP5Lg22yyG6xYdY1MFNsiNMUIYngv5M6/j1hiEo1b45eFfLQP0mDatbG
	awA6+cFckqyP/YUKdVpV+eLtoJ8srT84Kd2Fnk5FJ1+Xccpzu8S+
X-Received: by 2002:a50:fb83:0:b0:66e:e024:1a08 with SMTP id
 4fb4d7f45d1cf-67c1abb5f6cmr129376a12.24.1777665913232; Fri, 01 May 2026
 13:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
 <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
 <CABEuK14__XuRO2KOd3w+qx5_nw4iB2yPcF2R68a09A4hcJkyFw@mail.gmail.com>
 <4cbd1b20680e2dceba8870f62f2081c333113192.camel@linux.ibm.com>
 <CAFn2k5BciHURkQS9p-vZ70GP==1S_4GmoE=sMhA+WQXOA8nfoA@mail.gmail.com> <027d076e3ef0b22b648d024aaa7d8dd27746a624.camel@linux.ibm.com>
In-Reply-To: <027d076e3ef0b22b648d024aaa7d8dd27746a624.camel@linux.ibm.com>
From: Sahil Gupta <s.gupta@arista.com>
Date: Fri, 1 May 2026 15:05:01 -0500
X-Gm-Features: AVHnY4LB_CSKU5v9tO_ZHXUnJz_ZRVxFTS_f5tta5P7GGZV1DAKP3c9nWAoIBaw
Message-ID: <CABEuK17Z4UrCTi=zJkU5t4XzSojkEYuLwP3XTGyDcqcMgtZzBA@mail.gmail.com>
Subject: Re: IMA: Avoid redundant rehashing on stacked filesystems backed by
 structurally immutable filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Danny Hu <dannyhu@arista.com>, linux-integrity@vger.kernel.org, 
	Julien Gomes <julien@arista.com>, Pierre De Abreu <pierre@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 3F5614AF638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9402-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.gupta@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,arista.com:dkim]

I don't think inode immutability would be helpful here either because
you can mark an inode as immutable after you've written to it.

Sahil

