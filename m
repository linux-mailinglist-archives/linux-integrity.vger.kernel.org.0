Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8646930C4AD
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 17:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235911AbhBBP7J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 10:59:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235838AbhBBP5Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 10:57:16 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 112FXEVb090901;
        Tue, 2 Feb 2021 10:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9r17lNs77bNBkjR3HLg8HUIFHcTw/SLS9QTLkHpoKVg=;
 b=V7LhrSD3FEpYF7sdurP7mRbN/qIMCow7zxND5ovSaPaYcylqP7Mil84XKIfah0jkm5j+
 GijsmHC6OW4hcdO4o0EY/a07K9ARGuV8df59lyEOc6Lkz1H8RaDztxq7DdNlHVK3Pebu
 4ZdYhraZtiocJk5RUeiNtXw1YCxE5xhzJGFiQLLhhzZhfN0nbYnv6zLWf4EbQ0ltUWIq
 BzJkz1RSxznDUetjhPu3iQkPOKqaEWNsEsEamW4E/z18XNOq3aXY7lM0501DkFNlpY9H
 k8OZKoeMXUcUHjYThqe6QhoD1y4F4SZedRd+o6Qo/AUJhkx3JMS+Eux3maYirqPXkAoB GA== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36f987h9et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 10:56:28 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 112FaoJ9009620;
        Tue, 2 Feb 2021 15:56:27 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma04wdc.us.ibm.com with ESMTP id 36f0yukcvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 15:56:27 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 112FuRBU32702830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Feb 2021 15:56:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DFF6AC05B;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 167EBAC05F;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 0/2] ima_evm_utils: Add tests for ECDSA signature checking
Date:   Tue,  2 Feb 2021 10:56:23 -0500
Message-Id: <20210202155625.3555769-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_07:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This series of patches fixes the calculation of the keyid in the
sign_verify.sh script when it runs on older distros, such as CentoOS 7
or Ubuntu Xenial, and then adds ECDSA signature checking using elliptic
curve keys.

   Stefan

Stefan Berger (2):
  ima_evm_utils: Fix calculation of keyid for older distros
  ima_evm_utils: Add testing with elliptic curves prime192v1 and 256v1

 tests/gen-keys.sh      | 20 ++++++++++++++++++++
 tests/sign_verify.test | 16 ++++++++++++++++
 2 files changed, 36 insertions(+)

-- 
2.26.2

