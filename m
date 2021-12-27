Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7B8A4802D1
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Dec 2021 18:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhL0RaH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Dec 2021 12:30:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229940AbhL0RaH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Dec 2021 12:30:07 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BRGfv0N012232;
        Mon, 27 Dec 2021 17:29:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eHAnbEje+2RXpyDwqsUtjn5Q13CEzo0k3hqNmbHRXSU=;
 b=adhp57RcGPFlDF8EFfaPeCpfvM3d2Md+wFFRPxmz6elorLHQxW65OIkRrC9zZFeFJ9Sv
 injVbw4RJ9ictBWhuInfA+luh861526L+0jk8uj7etuvYrdu5uuWPWGRD68gyFp9hiyT
 FyzEs9onl7BTaTkAuUdpfxxfh3Tbvex2CEeXK60/hu/e+MBW8nGae6x4GJdWny0iwYC1
 UJRvNGawF4DTcAjucoPdUFNCbHPs3TG3/X24NOU+oM6JgPD9i8oCNd3bca9CfgpMBmla
 LFWaRYic5WBL3HIe0xgsphOFgRdIF1zz73I+gR42PjfsC0Yu+K2tL03mOz3XJInMIV6c Eg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ugt71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:29:45 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BRHSx9H005148;
        Mon, 27 Dec 2021 17:29:45 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3d7h7ugt6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:29:45 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BRHSfHm015004;
        Mon, 27 Dec 2021 17:29:44 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma04wdc.us.ibm.com with ESMTP id 3d70g0vqy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 17:29:44 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BRHTh6R31392220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Dec 2021 17:29:43 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8DAA0B206E;
        Mon, 27 Dec 2021 17:29:43 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D80FB2064;
        Mon, 27 Dec 2021 17:29:43 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 27 Dec 2021 17:29:43 +0000 (GMT)
Message-ID: <175831be-4c26-bd86-27c1-dd822514f06f@linux.ibm.com>
Date:   Mon, 27 Dec 2021 12:29:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v7 00/14] ima: Namespace IMA with audit support in IMA-ns
Content-Language: en-US
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
 <20211216125027.fte6625wu5vxkjpi@wittgenstein>
 <07c28891-5ac1-3c0d-bb67-cc49aca0aae2@linux.ibm.com>
 <20211217100659.2iah5prshavjk6v6@wittgenstein>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20211217100659.2iah5prshavjk6v6@wittgenstein>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6DFbx2RFHmnbDm17CXs8OzEzTwTavoQ7
X-Proofpoint-ORIG-GUID: av2GHDpP0c4hDkUguJNiO-8MRToECKsu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-27_08,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112270080
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 12/17/21 05:06, Christian Brauner wrote:
> On Thu, Dec 16, 2021 at 04:00:40PM -0500, Stefan Berger wrote:
>>
>> But that could still mean a lot of contention on iint->mutex since this
>> lock is global, i.e. in this context: for all ima namespaces. You might
>> want to consider coming up with some rough ideas for how to solve this
>> _if_ this becomes a problem in the future.
>>
>> The plan is that each IMA namespace will have its own rbtree with its own
>> set of iints. We cannot do it all at the same time, so this will take while
>> until things can be completely moved over into a per-IMA namespace rbtree
>> and each IMA namespace becomes fully independent.
> Ok, good to hear that you have already thought about that.


Well, yes, we thought about it. However, as far as I can look ahead we 
cannot get rid of the iint->mutex:

Obviously we have to organize the data structures where IMA is recording 
what it has done with a file/inode in such a way that each namespace can 
efficiently determine whether it needs to audit/measure/appraise a file 
or re-audit/re-measure/re-appraise it after file modification. The 
organization of these data structures also has to reflect the fact that 
files can be shared between IMA namespaces via setns() on mount 
namespaces or shared files or shared mount namespaces between containers 
etc.. So, the first thing we do already is move audit-related flags into 
what is called the ns_status (namespace status) structure that are kept 
in a per-IMA namespace rbtree. This allows IMA to remember that a file 
was already audited and it doesn't need to audit it again. The lookup 
via rbtree is quick: O(log(n).

Unfortunately the previous series had a bug so that files were not 
re-audited after they were modified. I fixed this now in the new series 
(upcoming v8) by connecting each ns_status also to a list. This list 
starts in the global inode integrity cache (the iint rbtree) where each 
inode that any IMA namespace accessed has an iint entry today. The lists 
start on the iint entries representing inodes.  When files are deleted 
or modified or xattrs are modified then all IMA namespaces need to 
re-audit/re-measure/re-appraise the file (depending on policy) and for 
this we have to reset flags across all the IMA namespaces by walking the 
list of ns_status entries. The organization via iint rbtree and 
ns_status list allows for quick lookup of the inode where the 
modification happened and quick reset of the flags: O(log(n)) + O(n). 
This is better than having to search all namespaces to reset the flags 
(O(log(n) * n) if there was no list.


     Stefan
