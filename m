Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7D976F5C8
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Aug 2023 00:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjHCWhp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Aug 2023 18:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjHCWho (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Aug 2023 18:37:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB3F1722
        for <linux-integrity@vger.kernel.org>; Thu,  3 Aug 2023 15:37:43 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373MCHtH017736;
        Thu, 3 Aug 2023 22:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=NMPbHmsRwkAoq3ntcMANlW/GSJeuKkG6VQKW4r0Dm44=;
 b=oCddjZnmInDNoDNwUSk2uEN0N5r7tBIYqBrLtAYiTr9BtfJhFddMluLUiosoV9xw4kkG
 UZzj00V21zD/MTEi5L5ISpG/oXlKta0aZSwYctU/bPF3wlGwfKXbeOA00NuQMcu4Tkuf
 ZGY50TuG9/cM4W9y5sTt1SA/Zebcntf1AdrdnuXscX5yQzzESzubARBkrJqEQgdDzpqb
 cIV+clPGhqAnLLmpS6qxUW8suVs6jD/mzaeJYDK6BhS0f1RoNb89SbahqOtDKICqn7aM
 UZp/BV9LbfySC8YHAbtsVHbq7sZPCAHh+xfWUHYyDNtU+bd5DprtRcKS2/mRFcweoZDa BA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mndghq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:37:20 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 373MTIDn007226;
        Thu, 3 Aug 2023 22:37:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s8mndgh1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:37:09 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 373KpvQF015879;
        Thu, 3 Aug 2023 22:36:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8kn70krx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 22:36:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 373MawMu5308976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Aug 2023 22:36:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEA7858063;
        Thu,  3 Aug 2023 22:36:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29F865805E;
        Thu,  3 Aug 2023 22:36:57 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.157.226])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  3 Aug 2023 22:36:57 +0000 (GMT)
Message-ID: <d51cd6959472885a59fc13b863b71f2157fc8f65.camel@linux.ibm.com>
Subject: Re: [PATCH 0/6] Measuring TPM update counter in IMA
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>, noodles@fb.com,
        bauermann@kolabnow.com, ebiederm@xmission.com, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kexec@lists.infradead.org,
        linux-integrity@vger.kernel.org
Cc:     code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
Date:   Thu, 03 Aug 2023 18:36:53 -0400
In-Reply-To: <a4a5e40b-abc1-27fa-3984-cee18fb4522c@linux.ibm.com>
References: <20230801181917.8535-1-tusharsu@linux.microsoft.com>
         <dbfb545b-9399-d505-6739-c2940930ef48@linux.ibm.com>
         <cb2029b8-d585-1c06-a0ac-15624cf70e28@linux.microsoft.com>
         <a4a5e40b-abc1-27fa-3984-cee18fb4522c@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 24gxbTS0-E0bQGvUb1J7in4krZhjiVJs
X-Proofpoint-GUID: 91ieXi7xNRZ8TnY0i0p3fLZvjYo-hPSa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308030203
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-08-03 at 18:09 -0400, Stefan Berger wrote:
> > I can remove the kexec example if it is causing confusion.> Please let me know.
> 
> I am not convinced we need this series  ... :-( Your kexec series prevents
> further logging and especially PCR extensions after the frozen measurement log
> has been created and in ima_add_template_entry(), if we hit an oom condition,
> then we luckily do not extend the PCR either. If either the log was to have one
> more entry than number PCR extensions occurred or vice versa, then the remote
> attestation service will see this mismatch no matter what and all the PCR update
> counter won't help (and is generally not a good indicator for this purpose imo)
> for it to recover from this. It's better to declare the system as un-trusted/
> corrupted in this case then.

As previously mentioned, there is a patch set that doesn't carry any
records across kexec, if the the measurement list is too large, and
another proposal to trim the measurement list.

In both of these cases including a new IMA mesaurement record, at least
after the boot_aggregate, would help simplify detecting whether the
measurement list has been trimmed/truncated.

-- 
thanks,

Mimi

