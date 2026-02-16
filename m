Return-Path: <linux-integrity+bounces-8506-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJnkJxf6kmlx0gEAu9opvQ
	(envelope-from <linux-integrity+bounces-8506-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Feb 2026 12:05:59 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBC2142A83
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Feb 2026 12:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C1A83008CBF
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Feb 2026 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D3C2F12C6;
	Mon, 16 Feb 2026 11:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OppS9KB+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vp0Bpwv9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFB822B5AD
	for <linux-integrity@vger.kernel.org>; Mon, 16 Feb 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239905; cv=none; b=SZ9uV+0lUoBbX0Pxq28Uvb4UTaCdugqIBBRCp5w2MIPHRqWgjbkfeMHtk2BsQPKralhjUeJ4x7Adlt9GQoN6hwlM24I2ATItsaAlbafeyFKQPawedXJ2kYiZ8c+UyNYZhh9KMb/G/nPOTorGMxEhhx0z2838/myJIiZIT9vHJgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239905; c=relaxed/simple;
	bh=xwRzJ3CVjxDVtF4g5dtQ/6rT6NS2KPIILMkhUqkpIXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Htf5+is6f7Lb8caGXDl9sa4/zDQwfL/MYrVnxusf1CderyuJpieo2eI0m0jxeWsoTP22GfjChKV8Cl5p0FGHQ5tXka7/MwqnN/Uj521dd9DY4r86dIg8x4wxodx9LHUNvhB3/7iY1fqhQib9g86WgB8kK6zq1xxj7/ixrCiXI/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OppS9KB+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vp0Bpwv9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GAtBBJ2647738
	for <linux-integrity@vger.kernel.org>; Mon, 16 Feb 2026 11:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1YdR03rD7ZpyV9jb9eSEhnHmP1wdw0dWCm1
	wpGBwvhc=; b=OppS9KB+5xUK3WxW5SNowfHh2S04kujrNSIhi8AT0pSKI0/uyu/
	a5XjCGJRN2uzP/gkL4rCW/0UMnqScaJ5G3/SLxrMc1NQB/CNHqxNZ0pbnW2Td9+t
	OS+dNVeTCm6ek5XNFd+WWRdAYD0iQCdteuJgg9/DxmjUnBVah/JGBrvNYchtiSA4
	+qZNbbzHbQdNXRjbSAHXtr5gaptq+8X8rzlkSXOH8wnF0qfRZLfGnGQZv8DlnIOp
	Dwm+fahRz0SlNCFPbaXKGmUayYjWwa2DuNwooT//prXFgXtUcLtFhLG1TCgDIzsR
	Ba+HtL7ic5wZHtAdrRIRht1Vd40z5zw0ATA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cbfuw1vcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Mon, 16 Feb 2026 11:05:03 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c70e610242so1873557485a.2
        for <linux-integrity@vger.kernel.org>; Mon, 16 Feb 2026 03:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771239902; x=1771844702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1YdR03rD7ZpyV9jb9eSEhnHmP1wdw0dWCm1wpGBwvhc=;
        b=Vp0Bpwv92z0BRTRUXZQLMh9TnGSF8uscZBkj1f1x71hjfUthXbge3ueAs+y+kIOZ8N
         iVGG5IjvuT4Hq+NO5gf9h0y/qbjVTxzixRKT5Tk6fsaPyphx/V7tWzK+W6Kxu+tqKHyY
         i08v/xqDqr19oDqOfK5mt8qVlkRvn8ByynJqbrRpmFilZF/ZF65Z3gLvbI2otn0JNQQ7
         Ti27rrLn9U+uDdnUYEm1fuFCVNb5rnpK5Nf48FWnlt2YjtvFYtcLrQeJdbdR4IWJMDJk
         2pk3IIEgU4yUMs8eYIlw6/WtTb5UbY/znjibPj/D45pqP4y2xDRj4SdSLDU3zJdoYKDI
         1/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771239902; x=1771844702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1YdR03rD7ZpyV9jb9eSEhnHmP1wdw0dWCm1wpGBwvhc=;
        b=woK+vN6II1x9ZNT8wGXWP1Rj5SnAmBVotz9Lzs/9FlcRhG7wxS2MoXVDpnJh2JUqNv
         ifG0ULkKQEX7IQKFxhgsjLz+G/CrYaLnYxTgx42FUwuH5JiWjPBLaPCCDihad57nmzPU
         t2IsfmYaYv+twjgkK83hTPYvFMeeHJy72rW6YGOoEk5hhPWTKMO29qU4f8tfioqp9ROz
         V2qjcr2Ici3gHL6z0smGgfFM6Ps7LR7r3B0C4NTK4bOam33Negr0fV4WWmsCFOoXmIJN
         /iQMPKAAVPavRw3SJspfsuOzaf4lH1JN74hiJrMOXKMcUTH73clfxd0ZIYmwEn88qOCl
         FXVg==
X-Forwarded-Encrypted: i=1; AJvYcCVDklKm1t2mGY9e6YMx0L8BybP542hpPSLuN9GGbJRdIL18ai6tb5zI8s1L2dVCOSTQGZGgrZm1TmovDokm/G0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYeqrtJw1UAs9phmAZwjaGXYSuEBI93IMLanA9HSn2uP6sytA
	4HkdsL9ocBHa0ngs2WvzhVJZ10agZ8Ok3fZLklLyzs4F3OesVCNODmmkJDjKxV70f7POduCSUBB
	P6vfLLR6NiGhMRipy+M+P06yi1Bi6AoYkpD/QuLgxN0zvuUA76dCaAV1tJMRcuMj8tqD40O8=
X-Gm-Gg: AZuq6aLBcDNCcIKBGKumoCKTz+5Kh28yIVxhdEQQcpAXt1ozPUTNioo9pzviKAnSA+a
	6FiqcwGO3dPxHoJ+XpzYRn3f/WQ77EZk1tw63mhm1UJrOFWjNwhtFYIZXZUDDrGD4yLteubBiuX
	kDjtYA7ymgQM5UtVlr+DItoqsvu6lRf0+hvph7WK/I0uy4j5lKofb9jypw2RPurchi6J/d33Aur
	zVsdHir8VappWgMl4x9t+LP9CALDSrD7ZljVUiW6UQg1B2ih16f6wGo3bfrhnX3QuauQZMLoUB5
	jdzegop25rp0QMZ0SI1ADt9uzyjZZAmoNc6nEtbnDrKU855uuBuXFbSa6RYJevFJMBMSZAP5CEs
	M5lF1llDFTLMmdmx33otM5ay/8JBJQDj9oz9TQQ==
X-Received: by 2002:a05:620a:1725:b0:8c5:310d:3b2d with SMTP id af79cd13be357-8cb4229f08cmr1203766885a.33.1771239902422;
        Mon, 16 Feb 2026 03:05:02 -0800 (PST)
X-Received: by 2002:a05:620a:1725:b0:8c5:310d:3b2d with SMTP id af79cd13be357-8cb4229f08cmr1203762485a.33.1771239901878;
        Mon, 16 Feb 2026 03:05:01 -0800 (PST)
Received: from quoll ([178.197.223.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dcfb28dsm389300025e9.11.2026.02.16.03.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 03:05:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] tpm: Make tcpci_pm_ops variable static const
Date: Mon, 16 Feb 2026 12:04:59 +0100
Message-ID: <20260216110458.160357-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1004; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=xwRzJ3CVjxDVtF4g5dtQ/6rT6NS2KPIILMkhUqkpIXs=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpkvnaNkEpSElmWzgShI9w037NIMx8zJ3k6byPn
 t6nTqpGt/mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaZL52gAKCRDBN2bmhouD
 10p5D/48RCLtwDruY6O5AG1lq04dAa8cS3Ci6ksDHzUdB+oCa1hZk9IgHO0N0tPQE6V7u9FPwMt
 ryUoIwG7AwT1fn4qz9EcWt1T733yIlQ0gDmtUJgbUh9rqUSsyEmzp5YTPkB1HzLpr7GAdMNQV46
 HWjtqfq/GgqLlf0lwBhtHk2fnf1Kt9UzyxOy5w0384ZENxFGl00yUjI20tOEGu6iLY96LH3bHF0
 sb6Sf1rmpy2urJAheEukcjJrKx+2CEfASArT18Z00vB2YmudCMIgmFnTS3tP77bLIQC1WkBQMs5
 QYooylHLr1FTpflMT7XwKq1tmQSocEcIK0PWLQUo7XKCciuE4l1G8EwulM4JJFzn8AdHirXf9RK
 tnQr58PDWU86Bhi7IJdwpRmfj+gXoi4rThtHuYjol3g1vY3jMfsMqYGxAL+EfstKz+s4PQ4EQuY
 /d+/nwM9BB+MfyIXGNy8YFm4No4B6k36M3gjx9ZXJF3jBSpMDfmEsTeApRx+Sgz3RGZRdvJaCdM
 vW2H1SXdXGWIOWRhCl7DWm7fQdlkqf93NLyXS4Q8fUX2HW6oOlnF7giilh6AEHS7BGO0eoP6BLL
 gLAjAFoEjA9+dIul7YAWaKX4VBNEsQLNLPOQQb5juX0i0smwYM9ptTVMQk8IEOJOTLr874Q4ezT kUearkoPAUtEsQA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jb+xbEKV c=1 sm=1 tr=0 ts=6992f9df cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=6nO30s3o7FuWeffXwhKHTA==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=EUspDBNiAAAA:8
 a=8XC4yJfEbrSXX8NmzEEA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Z1ZZgLXTD52kLnCovV56zm9v0si7ng7B
X-Proofpoint-GUID: Z1ZZgLXTD52kLnCovV56zm9v0si7ng7B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDA5MyBTYWx0ZWRfX3U9w+lg7U9pC
 HpzDdssn7Ju/9EgK9qkcV5AuDTV3s4HLUaARGTNqeV6oUCMxaFKP1UVXDBglS9cTR+QnrPQ2UYt
 GuQdRBJee5qJ9GzMgU/mQ4KPZvUEiT9XRyct/6DLwTrLiJHxx3upXSHub0aZT7nBefdJVBlls7Z
 Vf29/5eNcwU137iU2m0uBdlW04QvLXX92fVcvtiXFeDE+lwTkGDIcBxxjWPvTet3XGeyIb3uFOs
 mpagYcX5s3C5hDZabjJ+7DhMy8DhFcXXV5bjzdkbHo+T4qTDPatMHDy4zUs/4vBKzDumJ7JMXEQ
 MJKhN9BbWI0bZEP5AVWFRB1oGdNJxoASN25kBFJmTirqo95qhuGzYuzGbmgQCK+cmv2ywzpu4bA
 T34T4ttQ4ORNMygO0VcrxkUovwodWsHkHQlA7pXP33E4t9gmEDVOfDLPy9lJpACcR/sCgCbbNLX
 UAqa0sVLVRQDZRmBBtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_04,2026-02-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1011
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160093
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8506-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,kernel.org,ziepe.ca,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CFBC2142A83
X-Rspamd-Action: no action

File-scope 'tcpci_pm_ops' is not used outside of this unit and is not
modified anywhere, so make it static const to silence sparse warning:

  tcpci.c:1002:1: warning: symbol 'tcpci_pm_ops' was not declared. Should it be static?

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 3a77be7ebf4a..e00f668f8c84 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -21,7 +21,7 @@ static bool disable_pcr_integrity;
 module_param(disable_pcr_integrity, bool, 0444);
 MODULE_PARM_DESC(disable_pcr_integrity, "Disable integrity protection of TPM2_PCR_Extend");
 
-struct tpm2_hash tpm2_hash_map[] = {
+static const struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA1, TPM_ALG_SHA1},
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
-- 
2.51.0


