Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF5F5F309
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 08:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbfGDGpa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 02:45:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbfGDGp1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 02:45:27 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x646gQqr077944
        for <linux-integrity@vger.kernel.org>; Thu, 4 Jul 2019 02:45:25 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2th8t9puj6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jul 2019 02:45:25 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Thu, 4 Jul 2019 07:45:24 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 07:45:19 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x646jIW138338826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 06:45:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3404AC06B;
        Thu,  4 Jul 2019 06:45:17 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4321AAC05B;
        Thu,  4 Jul 2019 06:45:11 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.146.222])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
        Thu,  4 Jul 2019 06:45:10 +0000 (GMT)
References: <20190628021934.4260-1-bauerman@linux.ibm.com> <1561991934.4067.17.camel@linux.ibm.com>
User-agent: mu4e 1.2.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v12 00/11] Appended signatures support for IMA appraisal
In-reply-to: <1561991934.4067.17.camel@linux.ibm.com>
Date:   Thu, 04 Jul 2019 03:45:07 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19070406-0064-0000-0000-000003F7088F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011376; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01227188; UDB=6.00646128; IPR=6.01008425;
 MB=3.00027580; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-04 06:45:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070406-0065-0000-0000-00003E225467
Message-Id: <87k1cyl2mk.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040087
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> On Thu, 2019-06-27 at 23:19 -0300, Thiago Jung Bauermann wrote:
>> Hello,
>> 
>> This version is essentially identical to the last one.
>> 
>> It is only a rebase on top of today's linux-integrity/next-queued-testing,
>> prompted by conflicts with Prakhar Srivastava's patches to measure the
>> kernel command line. It also drops two patches that are already present in
>> that branch.
>
> Thanks, Thiago.  These patches are now in next-queued-testing waiting
> for some additional reviews/acks.

Thank you very much, Mimi! Now I think I'm only missing acks for the
PKCS#7 changes in patches 2 and 3, and an ack for the s390 changes in
patch 1.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

