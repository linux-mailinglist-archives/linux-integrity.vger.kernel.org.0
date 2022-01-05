Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13364853A0
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Jan 2022 14:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240379AbiAENfs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 5 Jan 2022 08:35:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233322AbiAENfr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 5 Jan 2022 08:35:47 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205AavW4002841;
        Wed, 5 Jan 2022 13:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=JCtG+qvIRUceUIqjbmYOWO6F7GjTYRbnQN4/z6HdpA8=;
 b=W3vt3sw4M8+tPsixTpXDawGnTCuoW3WxSK7fS0WTNqxcjI0o8+/n3oz/BKE4Y78nocvk
 dNRLmlLON0PYKr5x8X5m7y3LS/L/z0E+fRiokglX4YklIwRhpuCao0PAsLG2yhAn5iUU
 l3MWy3JS38jEzdM6CY8q69k/DbyW04Kv1S5BjtQz8yI4jaRXv0YJl1pk+cCrmbxKMTFI
 MyizmsiCC7sxZUWInoeYr5nhDOGlVdlUJ4ecmVxtMchL+XOwAp/d/R3xmmh/WFyPpP7o
 a1rX63kiGh/1tzP3NysOorRg8SNPlQn8gRmlXCRiFmISkNHY1cL0yUctk5AN1EER1RvM rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcp4tf6tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 13:35:47 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 205CpMx0025643;
        Wed, 5 Jan 2022 13:35:46 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dcp4tf6sg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 13:35:46 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 205DXxnr016323;
        Wed, 5 Jan 2022 13:35:44 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3daek9syp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Jan 2022 13:35:44 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 205DZgFC35324378
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Jan 2022 13:35:42 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A8094C040;
        Wed,  5 Jan 2022 13:35:42 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 546C74C050;
        Wed,  5 Jan 2022 13:35:41 +0000 (GMT)
Received: from sig-9-65-80-221.ibm.com (unknown [9.65.80.221])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Jan 2022 13:35:41 +0000 (GMT)
Message-ID: <4dc32716cf6e226539ad56cef9a372d26fc54dcc.camel@linux.ibm.com>
Subject: Re: [PATCH v4] ima: silence measurement list hexdump during kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 05 Jan 2022 08:35:40 -0500
In-Reply-To: <20211229020303.357610-1-bmeneg@redhat.com>
References: <20211229020303.357610-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0daHKGgcCEfTHQqwkmGTLDqd6GQdkRhR
X-Proofpoint-GUID: -jHT0Z7cgJID2KQteURKwCSXUoYKw99r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-05_03,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201050090
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2021-12-28 at 23:03 -0300, Bruno Meneguele wrote:
> Direclty calling print_hex_dump() dumps the IMA measurement list on soft

^Directly

> resets (kexec) straight to the syslog (kmsg/dmesg) without considering the
> DEBUG flag or the dynamic debug state, causing the output to be always
> printed, including during boot time.
> 
> Since this output is only valid for IMA debugging, but not necessary on
> normal kexec operation, print_hex_dump_debug() adheres to the pr_debug()
> behavior: the dump is only printed to syslog when DEBUG is defined or when
> explicitly requested by the user through dynamic debugging.
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

Thanks, Bruno.  This patch is now queued in #next-integrity-testing.

Mimi

