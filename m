Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4A645CC97
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Nov 2021 19:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbhKXTBS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Nov 2021 14:01:18 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236702AbhKXTBS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Nov 2021 14:01:18 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOItDsI026252;
        Wed, 24 Nov 2021 18:58:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=oU2PgaB/7TUuXyIE9hOW5QpAobwNCXZMt0mhuTqtroQ=;
 b=kQGH7RU2ifp2AyVOxhb7XjS3CZ7atIAu9mmspQohs2RSqsLhRDoGPJuOD6NPqBcXM56g
 MZh/ViSB7xlIETyeaAfCtqracWMk/8yZki1mZGhAXnMUzDnMeYHhzZOAtj3eDGg1uiJI
 MoZWTRb3Vj2V2sPp7nyCQy5oc0KrY7GN47w9fn7ioMlYgPpgmEHWW3pJ44Q+BH0t0SiB
 utnUOpq8K0YWrSiVprkmSBSYAC51G7ZclKbAoC+HHQ4dWoOtBwBEVhiupT7rqsVAl3T5
 hDk8ybo8S7WhceZQnfLuCe1xYyw1+a+fXQAuLb0TOnkVkLz6Yw+NFRFvlbnNs2jMUEkI qA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chrbruqsr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 18:58:03 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AOInWnr006998;
        Wed, 24 Nov 2021 18:58:02 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chrbruqs7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 18:58:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AOIr178027210;
        Wed, 24 Nov 2021 18:58:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3cernacmxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 18:58:00 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AOIvwlI29753742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 18:57:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EAA81A4057;
        Wed, 24 Nov 2021 18:57:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20E03A4053;
        Wed, 24 Nov 2021 18:57:57 +0000 (GMT)
Received: from sig-9-65-87-230.ibm.com (unknown [9.65.87.230])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 18:57:56 +0000 (GMT)
Message-ID: <68b1000251c5c45909f85f9229412a4688cc4500.camel@linux.ibm.com>
Subject: Re: ima-evm-utils: version 1.4 released
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Bruno E. O. Meneguele" <bmeneg@redhat.com>
Date:   Wed, 24 Nov 2021 13:57:56 -0500
In-Reply-To: <YZN9pJeU6rDfEzVr@pevik>
References: <9af9143c2c90f1ebae6cc34a7100673332cce1a1.camel@linux.ibm.com>
         <YYToG+8u/edIcc3u@pevik>
         <e7213f8c-a6f5-f73e-d88f-a264e6d231bb@linux.microsoft.com>
         <9475f96833540e0601b23b40cbc1dcbc30903ec6.camel@linux.ibm.com>
         <YYmLOoa6E78G3ii2@pevik>
         <ca8a4b45b3d7449b41b244217dddc9c91335780c.camel@linux.ibm.com>
         <YZN9pJeU6rDfEzVr@pevik>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iSMIGaqpxhQ6J87epsl4G5T6rIxsNwrD
X-Proofpoint-ORIG-GUID: 4fD6l0EhKvNd2gLEnqtYsKw2InQjHyfM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_06,2021-11-24_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2021-11-16 at 10:45 +0100, Petr Vorel wrote:
> Hi Mimi,
> 
> Great, thank you! Also, when you have time, could you please put there
> checksums? (ideally sha256/sha512) or even signed checksum file).

The github documentation is lacking as to where to put the release
checksums or signed checksum file.  All I've found is that it isn't
supported.  Here are the hashes:

sha256:fcf85b31d6292051b3679e5f17ffa7f89b6898957aad0f59aa4e9878884b27d1
 
sha512:2fdf41470d88608162a084c4877ba17d531941b744bcb44dd4913e48ab2c2d13
1e0af3e3ead74c18748a5d46aced51213ebd7c13a5ee19050c28d54a26c011a3

thanks,

Mimi

