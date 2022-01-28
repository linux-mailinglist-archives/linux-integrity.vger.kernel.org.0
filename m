Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793AC49F1AE
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jan 2022 04:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242244AbiA1DN3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 22:13:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9652 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237367AbiA1DN2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 22:13:28 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20S25wCa014436;
        Fri, 28 Jan 2022 03:13:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=niwnsspc+0m/djc9VCeaEIlzaMoR2WyoEQNdS4n3Jkw=;
 b=dCuh0I4hrKlk9tlBhDuz/DMTDVNyXnAOqmNodM4LDT2G/blikkCz4si1KARdgTDQZhX5
 bguUpp82u66GXlpDII20nIDwi0H0p10PTMZcoxYpSgfKN8ESt5yLvW4HCYSgYvR0fcmD
 Drq5yNtpn99/owvyBL3m9u+bGbQjGEE2OkGKVB/CxfLbLttf+w8AacJu1nb0XAGrSy7s
 QLwfCw2BPXCiL2jVUmbKxJbKw4ffcVxhPJBcjB/5AeSXdr8dg4zEpcFZZl8N58TEGavF
 aukdDegLkwknJXqyVYl3j5d2JmklwbKn0ItHfap4zn9LAu5JG+SUIwA/pOg1hw2q6Is3 ew== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv41wbt2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 03:13:14 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20S2w0aO007822;
        Fri, 28 Jan 2022 03:13:13 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dv41wbt2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 03:13:13 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20S38nTo029655;
        Fri, 28 Jan 2022 03:13:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 3dr9ja37sy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 03:13:11 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20S3D8MM48038256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 03:13:08 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 125F911C052;
        Fri, 28 Jan 2022 03:13:08 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6B4A11C04C;
        Fri, 28 Jan 2022 03:13:04 +0000 (GMT)
Received: from sig-9-65-89-165.ibm.com (unknown [9.65.89.165])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jan 2022 03:13:04 +0000 (GMT)
Message-ID: <714ef8a702e162fd9110f54801c02d626ee48a6b.camel@linux.ibm.com>
Subject: Re: [PATCH v9 10/23] ima: Move IMA securityfs files into
 ima_namespace or onto stack
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
Date:   Thu, 27 Jan 2022 22:13:04 -0500
In-Reply-To: <af944c80-aaa0-357d-eac3-f902c196fa0b@linux.ibm.com>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
         <20220125224645.79319-11-stefanb@linux.vnet.ibm.com>
         <20220126094042.l6jqu5swwsyhlt7v@wittgenstein>
         <af944c80-aaa0-357d-eac3-f902c196fa0b@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TRQu0avNXdrluKc7UhTqunLCAg2fr-aX
X-Proofpoint-GUID: ytlK9zDwHEDKX7IX53zbfutovTFuJA6f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_06,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280014
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-01-27 at 12:02 -0500, Stefan Berger wrote:
> On 1/26/22 04:40, Christian Brauner wrote:
> > On Tue, Jan 25, 2022 at 05:46:32PM -0500, Stefan Berger wrote:
> >> From: Stefan Berger <stefanb@linux.ibm.com>
> >>
> >> Only the securityfs IMA policy file is ever removed based on Kconfig
> >> options. For this reason, move the IMA securityfs policy file variable
> >> 'ima_policy' into the ima_namespace.
> >>
> >> Move the other IMA securityfs files onto the stack since they are not
> >> needed outside the function where they are created in. Also, their cleanup
> >> is automatically handled by the filesystem upon umount of a virtualized
> >> securityfs instance, so they don't need to be explicitly freed.
> > I'd reverse the explantion in the commit and mention the securityfs
> > change that makes this move possible which is patch 3 in this version of
> > the series ("securityfs: rework dentry creation"); something like:
> >
> > 	Earlier we simplified how dentry creation and deletion is manged in
> > 	securityfs. This allows us to move IMA securityfs files from global
> > 	variables directly into ima_fs_ns_init() itself. We can now rely on
> > 	those dentries to be cleaned up when the securityfs instance is cleaned
> > 	when the last reference to it is dropped.
> > 	
> > 	Things are slightly different for the initial ima namespace. In contrast
> > 	to non-initial ima namespaces it has pinning logic binding the lifetime
> > 	of the securityfs superblock to created dentries. We need to keep this
> > 	behavior to not regress userspace. Since ima never removes most of the
> > 	securityfs files the initial securityfs instance stays pinned. This also
> > 	means even for the initial ima namespace we don't need to keep
> > 	references to these dentries anywhere.
> > 	
> > 	The ima_policy file is the exception since ima can end up removing it if
> > 	a non-default policy is written at some point.
> >
> > Last sentence should be checked for sensibility by ima folks.
> 
> I remove the if clause and took the other text as-is...

Or replace it with, "on systems that don't allow reading or extending
the IMA custom policy."

thanks,

Mimi


