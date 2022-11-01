Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F96154D7
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 23:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiKAWQV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKAWQU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 18:16:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C5BCAC;
        Tue,  1 Nov 2022 15:16:17 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KRAKP008040;
        Tue, 1 Nov 2022 22:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MVmXSnPEYpXgPb+mU3tzLNqZw2Hu/MrbP45ldgt5gTg=;
 b=gHacYxx8ZB6vvdmf36u3pQ4WRdwwF7iuONBvNmdtLIukmorNMKLEXf6l58EaViBAd52S
 KQFgef/pMuUNbSs0fiiH6MCtpOLVlPdb/h9HcpxwC2vJ/ywi/pR9lbVUYqrByrBEVURA
 T48imqE7O3LQ/aZNYMxN0+8iZ+ZyewiuIap858lLJRAwSR37pHp7N/DMEQFv42J8oDLK
 7uFxBj6UmxcIxlW4LnsGHPstyJZ2NMS4qExRbD+VKO7BpUvwBtZnWtdFVlJXH6yJB0KN
 e0/jghrIL50kufHnY4+CyhdvUST0DJ4RQT6lA6onQsRzP/oyMopMwuzI0tXJeSS/Ll46 Sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjvbhgq5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 22:16:03 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A1L4t54009376;
        Tue, 1 Nov 2022 22:16:03 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjvbhgq59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 22:16:02 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1M4k9w022293;
        Tue, 1 Nov 2022 22:16:02 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma02dal.us.ibm.com with ESMTP id 3kgutacdu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 22:16:02 +0000
Received: from smtpav03.wdc07v.mail.ibm.com ([9.208.128.112])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1MG0XW40436212
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 22:16:01 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C9775805C;
        Tue,  1 Nov 2022 22:16:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EF8D5805F;
        Tue,  1 Nov 2022 22:15:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.106.109])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 22:15:59 +0000 (GMT)
Message-ID: <db821df65b7ff7319c657a1de65f5ba903599fc4.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] ima: Handle -ESTALE returned by
 ima_filter_rule_match()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     "Guozihua (Scott)" <guozihua@huawei.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Janne Karhunen <janne.karhunen@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 01 Nov 2022 18:15:59 -0400
In-Reply-To: <11716411-e143-ab1f-3b1e-d5d35f2a590a@huawei.com>
References: <20220921125804.59490-1-guozihua@huawei.com>
         <20220921125804.59490-3-guozihua@huawei.com>
         <ce948f9e5639345026679b31a818cc12a247ce60.camel@linux.ibm.com>
         <77c9c86b-85a6-aa87-e084-59a70bb47167@huawei.com>
         <f321c638bf5572088a8c5e4d7027c3a797bdd568.camel@linux.ibm.com>
         <7ac3e330-e77c-95d8-7d3b-29e243b57251@huawei.com>
         <5e304b17fe709d2b2f30b991d5ffc4711d27a075.camel@linux.ibm.com>
         <2f032b6c-ecf2-5a41-dc38-e6ab0a2d7885@huawei.com>
         <90f8940cff5eeef7917e2b11a07e41b32b207ffa.camel@linux.ibm.com>
         <38d5fd39-ead2-e954-5901-b35ef6ec96b6@huawei.com>
         <11716411-e143-ab1f-3b1e-d5d35f2a590a@huawei.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bzq1Fr0DEdBGPOne_7FWBUex5ICe6JzF
X-Proofpoint-ORIG-GUID: xA-pzWS3mc8caojG-QJpox-tM26QUSkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211010151
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Scott,

On Fri, 2022-10-28 at 16:36 +0800, Guozihua (Scott) wrote:
> 
> I managed to re-produce this issue with the help of the following two 
> scripts:
> 
> read_tmp_measurement.sh:
> > #!/bin/bash
> > 
> > while true
> > do
> >         cat /root/tmp.txt > /dev/null
> >         measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp\.txt" | wc -l`
> >         if [ "${measurement}" == "1" ]; then
> >                 echo "measurement found"
> >                 exit 1
> >         fi
> > done
> 
> test.sh:
> > #!/bin/bash
> > 
> > echo "measure obj_user=system_u obj_role=object_r obj_type=unlabeled_t" > /sys/kernel/security/ima/policy
> > 
> > cat /root/tmp2.txt
> > measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp2\.txt" | wc -l`
> > [ "$measurement" == "1" ] && echo "measurement for tmp2 found"
> > 
> > cat /root/tmp.txt
> > measurement=`cat /sys/kernel/security/ima/ascii_runtime_measurements | grep "tmp\.txt" | wc -l`
> > [ "$measurement" == "1" ] && echo "measurement for tmp found, preparation failed!" && exit 1
> > 
> > ./read_tmp_measurement.sh &
> > pid=$!
> > 
> > cd /usr/share/selinux/default
> > semodule -i clock.pp.bz2
> > semodule -r clock
> > 
> > kill ${pid}

Are you loading/unloading any selinux policy or specifically clock? If
specifically clock, what is special about it?

> I created two files tmp.txt and tmp2.txt, assign them with type 
> user_home_t and unlabeled_t respectively and then run test.sh.
> On a multi-core environment, I managed to reproduce this issue pretty 
> easily and tested that once the solution is merged, the issue stops 
> happening.

As I only see an IMA measurement policy rule being loaded for
"unlabeled_t" and not "user_home_t", should I assume that an IMA
measurement rule already exists for "user_home_t"?

thanks,

Mimi

