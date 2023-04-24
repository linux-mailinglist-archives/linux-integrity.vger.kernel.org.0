Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0FD6ED7A1
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Apr 2023 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbjDXWOS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 18:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjDXWOS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 18:14:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9715B90;
        Mon, 24 Apr 2023 15:14:17 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OM8xeW007455;
        Mon, 24 Apr 2023 22:14:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=zz76strXfWQb3PlBPdk/q+ueBLjUV07MIrSXwDmneYQ=;
 b=rJ/FNmkgsSH2bVBp5hTqHqXtr7+7iXU4RT0U1lC0TbgoguADm0OpwZI6W1LrRs8eC/7Z
 q5Tk63M8yxhPg7mGjz4qypwC0reIK+IahgjJol76fXD6hkVcwAJ2LevIRDUn7fxy01RF
 y8G7gMVePBWLxm5OQOMZU9oSGIvgbkDt9Vh61BQFJq7Svj8VGdsYG3x500HAnylVgnBc
 y3Jo9EzOLPp8nCSUfoTG8i6e0tsmm0oQvzeVFMVKap//puTBIfDyzuyFXGdgq1+jlalP
 lzGmVgOZnQNuvBBEELkPnROwUfKsPdn8tlRj//xS4DvvMTyBQX9+4SzCyDLa6Keursva WA== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q60sgbats-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 22:14:15 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33OIFKFq001323;
        Mon, 24 Apr 2023 22:14:15 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3q4778d8p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 22:14:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33OMEE8C14746280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Apr 2023 22:14:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 86D1558057;
        Mon, 24 Apr 2023 22:14:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4029658061;
        Mon, 24 Apr 2023 22:14:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.153.155])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Apr 2023 22:14:14 +0000 (GMT)
Message-ID: <a52062d55fd57032f224fef1a296b75345f4da16.camel@linux.ibm.com>
Subject: [GIT PULL] integrity: subsystem updates for v6.4
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 24 Apr 2023 18:14:13 -0400
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7Kc_wsmhwsDJDLQ0-UPkaLkNxRFnj_lP
X-Proofpoint-GUID: 7Kc_wsmhwsDJDLQ0-UPkaLkNxRFnj_lP
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_11,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=818 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240200
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

Just one one bug fix.  Other integrity changes are being upstreamed via
tpmdd and lsm.

thanks,

Mimi

The following changes since commit
eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-
integrity.git tags/integrity-v6.4

for you to fetch changes up to
644f17412f5acf01a19af9d04a921937a2bc86c6:

  IMA: allow/fix UML builds (2023-03-15 18:24:40 -0400)

----------------------------------------------------------------
integrity-v6.4

----------------------------------------------------------------
Randy Dunlap (1):
      IMA: allow/fix UML builds

 security/integrity/ima/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)



