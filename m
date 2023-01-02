Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0365B1AE
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Jan 2023 12:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjABL7X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Jan 2023 06:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjABL64 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jan 2023 06:58:56 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB5D695B6
        for <linux-integrity@vger.kernel.org>; Mon,  2 Jan 2023 03:58:09 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3027mRIm020847;
        Mon, 2 Jan 2023 11:57:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=71GDOYWwBy65RXO4QNxJR5FFH/9V489D7sK7K34KrJA=;
 b=N+OFpWE9RYga1OA4JnNWe8HTsv98t2Nvb44tblAcPcURLug2WzBDQ3/WcbZLzApih73r
 Dz59MY6GJK89ArmsCL3Naj6cg90vuNJVOBp0kv4OivBf9ZuUqHEbh76QVgopHgKTgBAE
 LZXWOsf5eADpY+9uixQhiaTkzPYkL7vxIc23V30Rn0X+WCBgB+LI+gkwerH7nTtXsmmR
 wtKqWOPGsUmJN/KQIRVBWSuVh/sU/OJXU7Rz9tD3ecAYwbrjGciap3Q2TgRTqgzRP+Qp
 0BC7lQOxA1lpiVFBDUxI8q1sMoLNNg/3pOmT16TYSwQP1RsEsKSJlFHx0ThjfjlyQBnz ww== 
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mtxhhfvr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 11:57:54 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3029I24W019422;
        Mon, 2 Jan 2023 11:57:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([9.208.130.100])
        by ppma02wdc.us.ibm.com (PPS) with ESMTPS id 3mtcq7c3cj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 11:57:53 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302BvqL99962096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 11:57:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 298FF58043;
        Mon,  2 Jan 2023 11:57:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 91FC85805F;
        Mon,  2 Jan 2023 11:57:51 +0000 (GMT)
Received: from sig-9-65-247-207.ibm.com (unknown [9.65.247.207])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  2 Jan 2023 11:57:51 +0000 (GMT)
Message-ID: <2a2c1ca896cdb8d1cf0b317de560921cf2785cd1.camel@linux.ibm.com>
Subject: Re: [RFC][PATCH 1/2] ima: created new ima template ima-dep-cgn for
 OCI containers attestation
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Enrico Bravi <enrico.bravi@polito.it>,
        linux-integrity@vger.kernel.org
Cc:     roberto.sassu@huawei.com, Silvia Sisinni <silvia.sisinni@polito.it>
Date:   Mon, 02 Jan 2023 06:57:51 -0500
In-Reply-To: <20221224160912.17830-1-enrico.bravi@polito.it>
References: <20221224160912.17830-1-enrico.bravi@polito.it>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: n7F5ca1qBEc8BgXJIr0eVneKxKfNJ3kI
X-Proofpoint-GUID: n7F5ca1qBEc8BgXJIr0eVneKxKfNJ3kI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_06,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301020105
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2022-12-24 at 17:09 +0100, Enrico Bravi wrote:
> Created new ima template ima-dep-cgn (dep|cgn|d-ng|n-ng) based on two
> new fields:
> 	- dep: list of dependencies of the process that generated
>                the measurement event. It is the concatenation,
>                column separated, of the execuatble's paths of all
>                ancestors of a specific task.
> 	       For processes belonging to containers, the dependecies list
> 	       contains the shim process that manages the container
> 	       lifecylcle. This ensures that a specifc process is
> 	       containerized.
>         - cgn: the subsys_id=1 cgroup name (cgroup_name()) of the process
>                that generated the measurement event.
> 	       In the case of conainerized processes this field contains the
> 	       full identifier assigned by the container runtime to the
> 	       specific container the process is executed in. This allows a
> 	       verifier to easily identify the the measurements related to a
> 	       specific container.
> 
> This template permits to separately attest the host system and each specific
> container.

The goal of this patch is fine, but more details need to be provided.  
For example, please include sample measurement rules here in the patch
description or in the cover letter with the associated sample output.  
An ima-evm-utils test, based on the github next-testing branch, would
be much appreciated.

thanks,

Mimi


