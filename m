Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0EB461719
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Nov 2021 14:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbhK2N6v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Nov 2021 08:58:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39634 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239262AbhK2N4t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Nov 2021 08:56:49 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDHBWu016371;
        Mon, 29 Nov 2021 13:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=Z1Wfyb4F8fdwAR3wxiOt8tHZLZLJ0R1TjEEDh/9qxAM=;
 b=R/vVMY/IPIev61VKIhpZMQlHiFtnWTjDrzhL0XyOMV/Az6v5QiKnevArwVe5xRegBDCf
 1bTol2d6FVEcMJyBprPiNbXG9lmczYDKZeV0qhmLhRxQkkW5Pxc59pCC1YgnvSHBmiaC
 JmnoLYE6uxoySqIz4eiEDreU1uW5UloEZOfY6k2qee2LytayIDx6It9MxWzf2czIfiij
 F2twM8aCrSxrxE/qoOcVKABmW34CvtE2R+nauG52+Sscd8uhyEsBwuTOy5S3xq8OXVyv
 z5s5/TozZR2RHDY92Lif4tuVnGXWCVjv/5da82ijSKLToPOjz1bA5a/XjbnzQlRk7LxN 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmym30vwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:53:20 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1ATDKe64001122;
        Mon, 29 Nov 2021 13:53:19 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cmym30vwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:53:19 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATDhucp012444;
        Mon, 29 Nov 2021 13:53:18 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 3ckcaaajbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 13:53:18 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATDrH3D43647346
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 13:53:17 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20C9F12405E;
        Mon, 29 Nov 2021 13:53:17 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3F77124066;
        Mon, 29 Nov 2021 13:53:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 13:53:16 +0000 (GMT)
Message-ID: <70b81e62-46af-9d39-3dcb-4cfbae645175@linux.ibm.com>
Date:   Mon, 29 Nov 2021 08:53:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC 3/3] ima: make the integrity inode cache per namespace
Content-Language: en-US
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-4-James.Bottomley@HansenPartnership.com>
 <20211129045834.GB20606@mail.hallyn.com>
 <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <755446b10c8415fd469b814535c4a12964af3264.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sV8GBu9twprefpYHvVBIj_l1TouIPr-O
X-Proofpoint-GUID: 8QeES-j3-IXiQmHn87ydsjCTrFyX4o62
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_08,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxlogscore=770 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290068
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 11/29/21 07:50, James Bottomley wrote:
> On Sun, 2021-11-28 at 22:58 -0600, Serge E. Hallyn wrote:
>> On Sat, Nov 27, 2021 at 04:45:49PM +0000, James Bottomley wrote:
>>> Currently we get one entry in the IMA log per unique file
>>> event.  So, if you have a measurement policy and it measures a
>>> particular binary it will not get measured again if it is
>>> subsequently executed. For Namespaced IMA, the correct behaviour
>>> seems to be to log once per inode per namespace (so every unique
>>> execution in a namespace gets a separate log entry).  Since logging
>>> once per inode per namespace is
>> I suspect I'll need to do a more in depth reading of the existing
>> code, but I'll ask the lazy question anyway (since you say "the
>> correct behavior seems to be") - is it actually important that
>> files which were appraised under a parent namespace's policy already
>> should be logged again?
> I think so.  For a couple of reasons, assuming the namespace eventually
> gets its own log entries, which the next incremental patch proposed to
> do by virtualizing the securityfs entries.  If you don't do this:

To avoid duplicate efforts, an implementation of a virtualized 
securityfs is in this series here:

https://github.com/stefanberger/linux-ima-namespaces/commits/v5.15%2Bimans.20211119.v3

It starts with 'securityfs: Prefix global variables with secruityfs_'

    Stefan


