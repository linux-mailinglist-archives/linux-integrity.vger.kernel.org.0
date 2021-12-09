Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E35746E06F
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 02:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235054AbhLIBzU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 20:55:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229680AbhLIBzT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 20:55:19 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8NpFij020559;
        Thu, 9 Dec 2021 01:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=lzNkL6HlG8uoD4LD2dknfufOrMTAzaPjmA2GavdwoYk=;
 b=bGfF52MtqCIan3T31khGXLZ5V9SQmsU4tNjRDTsPk0R+5fMLn2gtnBKPbdfDuVa5s9QK
 XmTVr0wMHAec3IqMumy0uRK150V/ZkYtf4Px4RsbTrVM9NS2NME5CgfEGqgnV82aUZ00
 papvyzMMEPdotAsvuLc65+p4/1d6b7TvD2FdY3ubuGHJYgUW4w64dSV5iQqjf1stp22s
 j91697c2DmCOoxj+0FsETRnoxKIVyspCZ/X0ets/IywZblS6I8ZBW/n5mKd5sRTVMANF
 C8GODj+RezSazeQblBkrne22Q7MD+gT2+p8iZAbeqaa2y20zWnjaUpcNtyfi0g7Nsbgn 0w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu1gk88we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 01:51:01 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B91k8st023060;
        Thu, 9 Dec 2021 01:51:00 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu1gk88w2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 01:51:00 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B91mA8k014682;
        Thu, 9 Dec 2021 01:50:59 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 3cqyybtxwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Dec 2021 01:50:59 +0000
Received: from b03ledav006.gho.boulder.ibm.com (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B91ovro28115566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Dec 2021 01:50:57 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 00C6BC6063;
        Thu,  9 Dec 2021 01:50:57 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1C6DC6062;
        Thu,  9 Dec 2021 01:50:54 +0000 (GMT)
Received: from [9.211.91.166] (unknown [9.211.91.166])
        by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  9 Dec 2021 01:50:54 +0000 (GMT)
Message-ID: <b5e6ec36-a9ec-22f4-be58-28d48bdc38b4@linux.vnet.ibm.com>
Date:   Wed, 8 Dec 2021 20:50:54 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/6] KEXEC_SIG with appended signature
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>, keyrings@vger.kernel.org
Cc:     kexec@lists.infradead.org, Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Rob Herring <robh@kernel.org>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <cover.1637862358.git.msuchanek@suse.de>
From:   Nayna <nayna@linux.vnet.ibm.com>
In-Reply-To: <cover.1637862358.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xrnPnY685HKWDzMtt8FN4mvhzwUwSKub
X-Proofpoint-ORIG-GUID: PnjZLCiMbUjVAQT56miJWZSqnDdO6KM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-09_01,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=984
 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0 clxscore=1011
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112090006
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/25/21 13:02, Michal Suchanek wrote:
> Hello,

Hi Michael,

>
> This is resend of the KEXEC_SIG patchset.
>
> The first patch is new because it'a a cleanup that does not require any
> change to the module verification code.
>
> The second patch is the only one that is intended to change any
> functionality.
>
> The rest only deduplicates code but I did not receive any review on that
> part so I don't know if it's desirable as implemented.
>
> The first two patches can be applied separately without the rest.

Patch 2 fails to apply on v5.16-rc4. Can you please also include git 
tree/branch while posting the patches ?

Secondly, I see that you add the powerpc support in Patch 2 and then 
modify it again in Patch 5 after cleanup. Why not add the support for 
powerpc after the clean up ? This will reduce some rework and also 
probably simplify patches.

Thanks & Regards,

      - Nayna

