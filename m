Return-Path: <linux-integrity+bounces-59-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF6D7ED733
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 23:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0921F1C208ED
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 22:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266B43AB5;
	Wed, 15 Nov 2023 22:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lPS9XATt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D09B1A5
	for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 14:30:11 -0800 (PST)
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6E7E120B74C1;
	Wed, 15 Nov 2023 14:30:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6E7E120B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700087410;
	bh=9kuRbTwEDCnlaY4fWGmVEgvxMIwpPB2ZxeKvyy6LxSA=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=lPS9XATtwFy0vuS7v7XHb+DOXMixr5FEczdQU1OQLUAMqYgpPHRrRjje/JbRDEXLT
	 JFTR4hPhjP9E/G/aEgkr01lKGxFE6qNQUPF8uc4VJxFEhn/RZPI+tIr4BszXfb2C8v
	 kh7tWmo0foWemsuxmUDPp8vHbmaAFubHZgD6BYZw=
Message-ID: <0263e2b0-6d61-4778-ad89-8fa01fd8034d@linux.microsoft.com>
Date: Wed, 15 Nov 2023 14:30:09 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] ima: move ima_dump_measurement_list call from
 kexec load to execute
Content-Language: en-US
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-3-tusharsu@linux.microsoft.com>
 <989af3e9a8621f57643b67b717d9a39fdb2ffe24.camel@linux.ibm.com>
 <57c97b4f-8489-4cac-8014-c16e4af8fcfc@linux.microsoft.com>
In-Reply-To: <57c97b4f-8489-4cac-8014-c16e4af8fcfc@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/14/23 14:43, Tushar Sugandhi wrote:
> 
> In addition, this patch moves the function ima_dump_measurement_list()
> to a new function named ima_update_kexec_buffer(), which is never
> called.   The patch set is thus not bisect safe.

BTW, ima_update_kexec_buffer() is part of the notifier_block.
which is part of the same patch 2/7.

+struct notifier_block update_buffer_nb = {
+	.notifier_call = ima_update_kexec_buffer,
+};
+

update_buffer_nb is being registered to the reboot notifiers in patch
3/7 of this series.

So ima_update_kexec_buffer() is being called.

+void ima_kexec_post_load(struct kimage *image)
+{
...
...
+
+	if (!ima_kexec_update_registered) {
+		register_reboot_notifier(&update_buffer_nb);
+		ima_kexec_update_registered = true;
+	}
+}

Maybe you meant 'update_buffer_nb' variable needs to be defined and used
in the same patch and not defined in 2/7 and used in 3/7.

Anyways, I think I took care of the majority of the bisect-safe issues 
from V1->V2 of this series.  But maybe I missed a few. I will look at
this with fresh perspective, to see if I missed anything, when I publish
V3 of the series.

Thanks,
Tushar

