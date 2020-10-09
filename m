Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84334288D4B
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Oct 2020 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgJIPtX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Oct 2020 11:49:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52122 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389457AbgJIPtX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Oct 2020 11:49:23 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 099Fl8qJ145624
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 11:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=to : from : subject :
 message-id : date : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=UCCkSJI+dNHyVJU5jhqco7sxHNn9Fg86LCneSDJ50mk=;
 b=J2xDMezXPx9YI3nvo4ARGrfBdqArnyJCwttn0ZXytsNtuahZpEcBVuPdcR1x5j3l+VvG
 UGeSgEJbwX9bTgEzaJZ6/NuV3EFCMjFRv4y3xcAz/xaEAtoMaTqNXMKr9tNW58bWGJ6B
 ZO/h2CBwbUgfEg/t5EDMXq6IqmeAa6EgLV4GhgVahh95kfBBVbgtMaFi5H9ntM7ouJTT
 78e91g8kcs+0JxQMI3DrPWiywfb/VlfPeNw1uDtbF7UpxRNCaTqRsCsj11ZGn+W1vy36
 5EJCmjFnaQYtUW/emMfS/qqHgJP+/yYyK30UDmpqcJWkmVyyYppPrVgpeQTaYPN5jfu6 zw== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 342ttd817x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2020 11:49:23 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 099FmTqQ018369
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 15:49:21 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma03wdc.us.ibm.com with ESMTP id 3429j36ctk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Oct 2020 15:49:21 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 099FnGQO48955880
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-integrity@vger.kernel.org>; Fri, 9 Oct 2020 15:49:16 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3DE3C605D
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:49:20 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A90E2C605A
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:49:20 +0000 (GMT)
Received: from [9.85.186.165] (unknown [9.85.186.165])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP
        for <linux-integrity@vger.kernel.org>; Fri,  9 Oct 2020 15:49:20 +0000 (GMT)
To:     Linux Integrity <linux-integrity@vger.kernel.org>
From:   Ken Goldman <kgold@linux.ibm.com>
Subject: [PATCH 1/5] ima-evm-utils: Change env variable TPM_SERVER_TYPE for,
 tpm_server
Message-ID: <df65521a-88b0-24f8-9bf6-fd4a4235eb6c@linux.ibm.com>
Date:   Fri, 9 Oct 2020 11:49:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_06:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090116
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The default value raw is appropriate for 'swtpm'.  tpm_server
uses the Microsoft packet encapsulation, so the env variable
must have the value mssim.

Signed-off-by: Ken Goldman <kgoldman@us.ibm.com>
---
  tests/boot_aggregate.test | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 1c7b1f2..b109a32 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -35,6 +35,7 @@ else
  	export TPM_COMMAND_PORT=2321
  	export TPM_PLATFORM_PORT=2322
  	export TPM_SERVER_NAME="localhost"
+	# swtpm uses the raw, unencapsulated packet format
  	export TPM_SERVER_TYPE="raw"

  fi
@@ -73,6 +74,8 @@ swtpm_start() {
  			SWTPM_PPID=$!
  		fi
  	elif [ -n "${swtpm}" ]; then
+	        # tpm_server uses the Microsoft simulator encapsulated packet format
+                export TPM_SERVER_TYPE="mssim"
  		pgrep swtpm
  		if [ $? -eq 0 ]; then
  			echo "INFO: Software TPM (tpm_server) already running"
-- 
2.25.1

