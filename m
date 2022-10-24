Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E096C60AE62
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Oct 2022 16:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiJXO7b (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Oct 2022 10:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236385AbiJXO7O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Oct 2022 10:59:14 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246BC814D5
        for <linux-integrity@vger.kernel.org>; Mon, 24 Oct 2022 06:36:22 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29OBhnpx008579;
        Mon, 24 Oct 2022 12:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : date : in-reply-to : references : content-type : mime-version
 : content-transfer-encoding; s=pp1;
 bh=Oaf1QUXAULuByfQw4+Tuo8nPnEIazzQo/YvOM0OVb8c=;
 b=dlA858ZHo2g3kw0xZhgdvJ6oJTahlR1lMpvxbhpYxSHH9WkxMb2lqhWdEY8dv1LmC1Af
 IYEsi6mH7HglnpVx6F+53h9W0dTkUcddfNHDBnJk3BOyx70M0TPkBBo4R7Px/gswa4t6
 t92yhU9nzGUAYeSxqCEU8/RHr3CAUjsMCO2zT70bakBjuN4liRlT4k5LSB8oqXXXl/It
 aZy5xdRzgwWCT9IvstrvqaOsyoQWaXf+HxRfv9Aix1UeCnsuKfke88mz+1hS0lBy/XLO
 KLkfvrwZNBUFpiSajb+ekBL8PwJvSKxPK3ekClVfjcN6lt5sw/OaJ/A5Gq9q984U59AY yw== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kdt33sabj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:28:02 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29OCKMHt023717;
        Mon, 24 Oct 2022 12:28:01 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3kc85awnja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:28:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com ([9.208.128.115])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29OCS0Hq5833388
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Oct 2022 12:28:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAD9B58055;
        Mon, 24 Oct 2022 12:28:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 53B565804E;
        Mon, 24 Oct 2022 12:28:00 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.81.179])
        by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 24 Oct 2022 12:28:00 +0000 (GMT)
Message-ID: <ba98a4074170d539fd785db6f18bc25715db1707.camel@linux.ibm.com>
Subject: Re: Expected appraisal behavior after script modification
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ken Williams <ken@williamsclan.us>, linux-integrity@vger.kernel.org
Date:   Mon, 24 Oct 2022 08:27:59 -0400
In-Reply-To: <CADrftwNYya==hLiZ+c=ZCJOt++JCVbCivjaeMWv8vKnF+pgOBw@mail.gmail.com>
References: <CADrftwNYya==hLiZ+c=ZCJOt++JCVbCivjaeMWv8vKnF+pgOBw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q6RURj8s87YbFQCC2ZwQw6EChH-BmkO8
X-Proofpoint-ORIG-GUID: q6RURj8s87YbFQCC2ZwQw6EChH-BmkO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_03,2022-10-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210240075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2022-10-23 at 20:07 -0700, Ken Williams wrote:
> I am interested in knowing the expected appraisal behavior after a
> signed script has been modified.  I am asking because I observe that a
> modified signed script can be executed.  In my effort, I did the
> following:
> 
> 0) Configure IMA with the only positive appraisal being:
> appraise func=BPRM_CHECK appraise_type=imasig
> 
> 1) Create s simple script, as shown here:
> #!/bin/bash
> 
> echo "Hello World"
> 
> 2) Try to execute the script and see a failure as expected:
> # ./hello.sh
> bash: ./hello.sh: /bin/bash: bad interpreter: Permission denied
> 
> and see:
> journalctl | grep INTEG
> Oct 24 02:26:32 ctx0700 audit[7135]: INTEGRITY_DATA pid=7135 uid=0
> auid=0 ses=4 subj=root:staff_r:staff_t:s0-s0:c0.c1023
> op="appraise_data" cause="IMA-signature-required" comm="bash"
> name="/sysroot/home/root/hello.sh" dev="mmcblk0p6" ino=23072 res=0
> 
> 3) Sign the script:
> evmctl ima_sign -k /etc/keys/privkey_ima.pem ./hello.sh
> 
> 4) Execute
> # ./hello.sh
> Hello World
> 
> 5) Modify the script to read:
> #!/bin/bash
> 
> echo "Hello World"
> echo "Hello Again"
> 
> >>>>>>>>>  ****************** <<<<<<<<<<
> 6) Execute the script and observe that the modified script executes successfully
>  This was unexpected.
> # ./hello.sh
> Hello World
> Hello Again
> 
> The signature was unchanged.
> 
> In order to avoid crowding this email with too much info, I have
> omitted some details such as the actual signature and the full policy
> (with dont_appraise fs=xxxx) and kernel config, but will be glad to
> augment this as requested.  But first, I want to start by
> understanding if this behavior is expected.
> I am running a 4.14.238 kernel.

The file open hook prevents signed files from being modified and for
hashed files results in the iint cache status being updated on __fput. 
Define an appraise "func=FILE_CHECK" rule.

-- 
thanks,

Mimi

