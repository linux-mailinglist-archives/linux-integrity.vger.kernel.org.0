Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9982AE0EA
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Nov 2020 21:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgKJUp4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Nov 2020 15:45:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgKJUpz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Nov 2020 15:45:55 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKXZKE077959;
        Tue, 10 Nov 2020 15:45:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=2VO+94e+Dk3VB+OstCmu/TP+xBZpBf20QR+VJ2RJ4Iw=;
 b=YAg0x/Y/qpct0OESH4xjIeGz8XzZ05jmx9EKr8K5iI8I+4MPdfJbmclxD0yfmgxs0gdK
 bpfXMsqB+Dnqre3jhYNhdDTpCAmBUR6m7AYhzeWnnprg1DEryUjPfqoQlF+gb6UiB36v
 W1ERckowXa+ZsceLu1jlI94xAy4FP2Wz62SMtpmkYzmizFZtAGrm/vopQi11tL5MGo/f
 9ksykmCPvDx0qNjgOrgqGiUTu7TlIQP/l/yrtZRavStv1S4Y+V3ViMGacjd2fDJjl5Wx
 5zJkvfHGGZmh5R3+yt4WTr9jtgumbKVVNCOVKLZdt2mmASAcva46LKyVN0QurvLYi9HT fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34r0992tgf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 15:45:44 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AAKXfbq078352;
        Tue, 10 Nov 2020 15:45:44 -0500
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 34r0992tfw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 15:45:44 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AAKfoZm025287;
        Tue, 10 Nov 2020 20:45:42 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06ams.nl.ibm.com with ESMTP id 34njuh3hda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 20:45:42 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AAKjejl57475442
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 20:45:40 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2C3D842042;
        Tue, 10 Nov 2020 20:45:40 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C80884203F;
        Tue, 10 Nov 2020 20:45:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.83.27])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Nov 2020 20:45:38 +0000 (GMT)
Message-ID: <0694c3637dddaaddb6a2a5b679c58448746bc70d.camel@linux.ibm.com>
Subject: Re: Selinux policy for x509_ima.der public certificate loaded by
 kernel during boot
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     rishi gupta <gupt21@gmail.com>,
        Mikhail Novosyolov <m.novosyolov@rosalinux.ru>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        selinux-refpolicy@vger.kernel.org, selinux@vger.kernel.org
Date:   Tue, 10 Nov 2020 15:45:38 -0500
In-Reply-To: <CALUj-gtQsSnU0Yq5Syc7aOkN0PH_MHvziuuG1-9zotVUAJ2QoQ@mail.gmail.com>
References: <CALUj-gt8KD4Cc-zgvXP-8vNdR3RB_Sdx7yd2cv7GX_wBCM6gEQ@mail.gmail.com>
         <28afd683-8423-0331-4b7d-ec71d46be30c@rosalinux.ru>
         <CALUj-gtyVJ9nLYWYbX2Oa9=dcCYqc2H0RkO4HQcJKj2ejAfSYg@mail.gmail.com>
         <bdd1becf-c72d-876a-cd9b-cef7b6fe55e9@rosalinux.ru>
         <CALUj-gtQsSnU0Yq5Syc7aOkN0PH_MHvziuuG1-9zotVUAJ2QoQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-10_07:2020-11-10,2020-11-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1011 lowpriorityscore=0 adultscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011100138
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-11-09 at 21:14 +0530, rishi gupta wrote:
> On Sat, Nov 7, 2020 at 3:45 AM Mikhail Novosyolov
> <m.novosyolov@rosalinux.ru> wrote:
> >
> >
> > 06.11.2020 18:50, rishi gupta пишет:
> > > On Fri, Nov 6, 2020 at 8:42 PM Mikhail Novosyolov
> > > <m.novosyolov@rosalinux.ru> wrote:
> > >> 06.11.2020 15:22, rishi gupta пишет:
> > >>> I am getting below error as selinux is denying access to the .ima
> > >>> keyring. Looking for guidance for asymmetric public key selinux
> > >>> policy.
> > >>>
> > >>> [  172.014855] integrity: Request for unknown key 'id:87deb3bf' err -13
> > >> I am getting the same error without selinux.
> > > If I make selinux permissive, it works for me. So I know in my case
> > > the problem is selinux.
> > >>> [  172.015035] audit: type=1800 audit(1604596570.579:240): pid=825
> > >>> uid=1021 auid=4294967295 ses=4294967295
> > >>> subj=system_u:system_r:mydaemon_t:s0-s15:c0.c1023 op="appraise_data"
> > >>> cause="invalid-signature" comm="mydaemon"
> > >>> name="/usr/lib/libstdc++.so.6.0.25" dev="ubifs" ino=14353 res=0
> > >> Selinux context is just logged here. It has nothing to do with reasons of ivalid signature. Public key seems to be not loaded.
> > > Basically when we access a file, driver checks if selinux allow access
> > > to it or not. In my case this function is returning -EACCES
> > > https://github.com/torvalds/linux/blob/master/security/keys/permission.c#L88
> > >>> (a) Do I need to set the selinux context of file
> > >>> /etc/keys/x509_ima.der. If yes what it should be.
> > >>> (b) Do I need to set some selinux rule for .ima keyring. If yes how. I
> > >>> tried a lot but could not find any resource.
> > >> Usually IMA policy is loaded before SELinux policy I think
> > > I am using the policy defined in ima_policy driver as of now. My kernel is 4.14.
> > What is "ima_policy driver"? How does selinux and IMA policies get loaded on your system?
> 
> For test purpose I am using "ima_policy=tcb ima_appraise_tcb" in the
> commandline.
> I have not changed anything in the policy defined in 4.14 kernel driver for now.
> https://github.com/torvalds/linux/blob/bebc6082da0a9f5d47a1ea2edc099bf671058bd4/security/integrity/ima/ima_policy.c#L132
> https://github.com/torvalds/linux/blob/bebc6082da0a9f5d47a1ea2edc099bf671058bd4/security/integrity/ima/ima_policy.c#L88

Is root able to verify a file signature signed with this key? 
Afterwards are you able to verify this file's signature?

Mimi


