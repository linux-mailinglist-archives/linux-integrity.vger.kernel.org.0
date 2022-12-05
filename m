Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5E964298D
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Dec 2022 14:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiLENjv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Dec 2022 08:39:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231959AbiLENjt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Dec 2022 08:39:49 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095851D0CB
        for <linux-integrity@vger.kernel.org>; Mon,  5 Dec 2022 05:39:49 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5D9w5x001540;
        Mon, 5 Dec 2022 13:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=pPDY1UiSpE18O/qu5pfimZftry6w/eGViAVI7fzvckc=;
 b=PhK3izt1Jh9x0upz2GjB1RDghRAGbkssyTiVHvQhCl/pTFXB3mfKwMlR2+v2tY+czj3z
 6RL3TxifH10ogVz1o9bh1wdmbFtJB8yg31Csr6rKggzObebVktsyFnsteEleBHXH0adf
 0v3cPBE0IfqyJysBTHx1qiGvrw9Us5ZprS739jJLhS9jttbEnTbIKTx7Z6N/C2kDZsY8
 zI3pyGSluIJsf/YNcb4WrYEoHt/W5Kb6c41GV0JAs4+KZXn5A7+gHoFFTsk5HVvwnM5y
 cLykE80jqynL7boo0sjU+QXUc6QRG2ay2JgHgoRpJ0CKN1c/oDywb1NoIEj0g3mEudXg JA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8g9qcwx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 13:39:36 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B5Cgoo3004074;
        Mon, 5 Dec 2022 13:39:36 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m8g9qcwwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 13:39:36 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2B5DZdGi004092;
        Mon, 5 Dec 2022 13:39:34 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([9.208.129.120])
        by ppma03wdc.us.ibm.com with ESMTP id 3m7x39drg2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Dec 2022 13:39:34 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B5DdXgX57278918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Dec 2022 13:39:33 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C71595805A;
        Mon,  5 Dec 2022 13:39:33 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 319455803F;
        Mon,  5 Dec 2022 13:39:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.106.247])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  5 Dec 2022 13:39:33 +0000 (GMT)
Message-ID: <7db27896916a944d8e4a212cad23865166ceb9f4.camel@linux.ibm.com>
Subject: Re: [PATCH ima-evm-utils] Experimental fsverity.test related GA CI
 improvements
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Date:   Mon, 05 Dec 2022 08:39:32 -0500
In-Reply-To: <20221201002654.2238906-1-vt@altlinux.org>
References: <20221201002654.2238906-1-vt@altlinux.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M0fC8nqMLAug0NJQ7RTe7KnijOF-e3mV
X-Proofpoint-ORIG-GUID: Cewme208ngQlwlW2NpqnB4hel4utl8US
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050110
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Vitaly,

On Thu, 2022-12-01 at 03:26 +0300, Vitaly Chikunov wrote:
> From: Mimi Zohar <zohar@linux.ibm.com>
> 
> This does not make fsverity.test working on GA CI, though.
> 
> - `--device /dev/loop-control' is required for losetup(8) to work.
> - `--privileged' is required foo mount(8) to work, and this makes
>   `--security-opt seccomp=unconfined' redundant.
> - GA container does not have `/sys/kernel/security' mounted which is
>   needed for `/sys/kernel/security/integrity/ima/policy'.
> - Enable `set -x` in CI as the logs is everything we have to analyze on
>   failures.
> 

Agreed, even with these changes the fsverity test will not be executed,
but skipped.

However, the reason for them being skipped is totally different than
prior to this patch.   Once the distros have enabled both fsverity
support and are running a recent enough kernel with IMA support for
fsverity, the fsverity test should succeed.

So the problem isn't the GitHub actions architecture or the fsverity
test itself, but the lack of IMA kernel support for it.  In addition to
the ima-evm-utils distro tests, there needs to be a way for testing new
kernel integrity features.  Roberto's proposed ima-evm-utils UML patch
set downloads and uses a UML kernel for this purpose.

Unless someone can recommend a better alternative, a single UML
"distro" test could be defined and would be executed if a UML kernel is
supplied.   Additional UML tests could be specified.

thanks,

Mimi

