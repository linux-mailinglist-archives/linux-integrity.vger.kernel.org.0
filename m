Return-Path: <linux-integrity+bounces-410-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C24F680F35A
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 17:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63311B20DE8
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 16:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061F67A203;
	Tue, 12 Dec 2023 16:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s6MjxxM3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77D4EA;
	Tue, 12 Dec 2023 08:41:33 -0800 (PST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCG8JuS015567;
	Tue, 12 Dec 2023 16:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=OBEYEjrDCz4TuBs07nl5GsWaYiiiFHG+n/liVJd/yj4=;
 b=s6MjxxM3Z3hO3/K17BpGnxnQeTU8+rqmQNie3gBH3uAW92HtwEHwjf1/kocTNulw8wF+
 970lFv8aCUZm5JgP7zpoj9Oxg9PqEGkOw3/3K47D9+T2Gws5O5WA/LKqpsb7ksxvO3wy
 1C1iqd8tcuD2dYeN9RRwqUytXxIfzRfjmdeg8we6WHn6aReW9H++kcqD/U63BBEje1MK
 7U/M2wW6xnKNUDoN/ZqR0q17HoRGI5qnqgu1q76olZZlD/3nF5PIe++Bv9HeW7bNseoJ
 l1w5MuLrj6/8lrBpF9jlN9t/3VdQ67V7Rc5KaxXj3HTTUQhQCKHRtxbT93hEMLsmt1Id iA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxt64ah2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 16:40:17 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BCGcsej014799;
	Tue, 12 Dec 2023 16:40:17 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uxt64ah1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 16:40:16 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BCFPjPG004899;
	Tue, 12 Dec 2023 16:40:15 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uw4ska17k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Dec 2023 16:40:15 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BCGeEU638994514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Dec 2023 16:40:14 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4565F5805F;
	Tue, 12 Dec 2023 16:40:14 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D66658059;
	Tue, 12 Dec 2023 16:40:12 +0000 (GMT)
Received: from gfwa153.aus.stglabs.ibm.com (unknown [9.3.84.127])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 12 Dec 2023 16:40:12 +0000 (GMT)
From: Ninad Palsule <ninad@linux.ibm.com>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com, ninad@linux.ibm.com,
        johannes.holland@infineon.com, linux@roeck-us.net, broonie@kernel.org
Cc: patrick.rudolph@9elements.com, vincent@vtremblay.dev,
        peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com, bhelgaas@google.com,
        naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
        festevam@denx.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-hardening@vger.kernel.org, geissonator@yahoo.com
Subject: [PATCH v1 0/8] Add device tree for IBM system1 BMC
Date: Tue, 12 Dec 2023 10:39:56 -0600
Message-Id: <20231212164004.1683589-1-ninad@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xym3WnYCyVgWyZYHKVAjtb_1ikuXnMGu
X-Proofpoint-GUID: hSmsCdiV-y1ye3PNOdvlyRWPbvIIxmIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-12_10,2023-12-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=947 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1011 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312120128

This patchset adds device tree for IBM system1 bmc board.

Change log:
v1:
 - Added device binding for IBM system1-bmc
 - Added device binding for TIS I2C devices
 - Added device tree for IBM system1 BMC board
 - Added i2c and muxes
 - Added voltage regulators
 - Added GPIO, Fan ctrl, Led
 - Added more compatible strings for tpm_tis_i2c
 - Added power supplies, sensors, EEPROMS, TPM and more

Andrew Geissler (1):
  ARM: dts: aspeed: System1: IBM system1 BMC board

Joel Stanley (1):
  tpm: tis-i2c: Add more compatible strings

Johannes Holland (1):
  dt-bindings: tpm: Add schema for TIS I2C devices

Ninad Palsule (5):
  dt-bindings: arm: aspeed: add IBM system1-bmc
  ARM: dts: aspeed: System1: Add i2c and muxes
  ARM: dts: aspeed: System1: Voltage regulators
  ARM: dts: aspeed: System1: GPIO, Fan ctrl, Led
  ARM: dts: aspeed: System1: PS, sensor and more

 .../bindings/arm/aspeed/aspeed.yaml           |    1 +
 .../bindings/security/tpm/tpm-tis-i2c.yaml    |   50 +
 .../devicetree/bindings/trivial-devices.yaml  |    2 +
 arch/arm/boot/dts/aspeed/Makefile             |    1 +
 .../dts/aspeed/aspeed-bmc-ibm-system1.dts     | 1644 +++++++++++++++++
 drivers/char/tpm/tpm_tis_i2c.c                |    2 +
 6 files changed, 1700 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
 create mode 100644 arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-system1.dts

-- 
2.39.2


