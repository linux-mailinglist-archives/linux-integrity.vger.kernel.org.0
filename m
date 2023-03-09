Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4883A6B309D
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Mar 2023 23:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjCIWac (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Mar 2023 17:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCIWab (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Mar 2023 17:30:31 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1927BF8F22
        for <linux-integrity@vger.kernel.org>; Thu,  9 Mar 2023 14:30:30 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 329L2IoA012167;
        Thu, 9 Mar 2023 22:30:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : content-type : mime-version :
 content-transfer-encoding; s=pp1;
 bh=25IVFFbtfnFIVKiKYt6caNGcIYa31y9UhPYjNQH5NCQ=;
 b=jKlBOO0NmV5iGdVvT4uSQapkZtER1017uZHKRVryMXWORw04gT8Fje2LqPYSimVWtW6Y
 yfxyT7lsJEXJf3l78rNjeEJF+PdknK/8lpr0Btow6UFBwwtqx2Q0NGGHlKYFno8AQ0ES
 0pBEyfuHam02BDl8SMA1DB2KTcTeBOFq7ZRtSkdYAMJeBnvqmhRAwk5xl8ty0d5xa9Es
 GxAYc22xTmLM+SqrY1VypW//DRUhSgPGqkAe9ihslj3tPR58PV38sHvNs3iT69X07wqS
 rNyjIqtYMP6hzqNDbj5WH5MBYgn/9kRuDfT9jfjPhId+k4nPrNAmabo/HDhhjKzqbYzP zA== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6rdhf0ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 22:30:17 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 329ImuEo025847;
        Thu, 9 Mar 2023 22:30:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([9.208.129.116])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3p6g9jbfp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Mar 2023 22:30:15 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 329MUEEk7406214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Mar 2023 22:30:15 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D744D58058;
        Thu,  9 Mar 2023 22:30:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EA855805B;
        Thu,  9 Mar 2023 22:30:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.72.201])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Mar 2023 22:30:14 +0000 (GMT)
Message-ID: <7360f93f5189b64efc1e1c1aeeb2f3cbed986db0.camel@linux.ibm.com>
Subject: ima-evm-utils: version 1.5 released
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@us.ibm.com>
Date:   Thu, 09 Mar 2023 17:30:13 -0500
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 40esAeexXHngZx2zCzrInQXEsnBLHXuD
X-Proofpoint-ORIG-GUID: 40esAeexXHngZx2zCzrInQXEsnBLHXuD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_12,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 mlxlogscore=769
 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303090177
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

There have been many changes since the last release.  The most notable
change is CI support for testing new kernel integrity features not yet
upstreamed and bugfixes, or functionality not enabled by distros in a
User Mode Linux (UML) environment.  Testing in a UML environment also
allows saving CI build artifacts, such as private keys, needed for
creating and loading public keys onto the trusted kernel keyrings. 
These public keys may be used for code - file data and metadata -
signature verification.

I'd like to thank Roberto Sassu for the UML work and the various tests.
I'd also like to call out Petr Vorel's, Vitaly Chikunov's, and Stefan
Berger's contributions - advice, patches and code review.  And to thank
the community in general.

Please refer to the NEWS file for the short summary and the git history
for details of the ima-evm-utils v1.5 release.

-- 
Mimi

