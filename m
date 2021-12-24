Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1973747EF27
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Dec 2021 14:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241694AbhLXN2I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Dec 2021 08:28:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15580 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230463AbhLXN2I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Dec 2021 08:28:08 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BOCbFTU019444;
        Fri, 24 Dec 2021 13:28:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=tHh/8uCQy9JgVntyacpMExlylc9GjZK/DoUajQE0/jo=;
 b=hrSOc1T6+p3wYuEcCerVjVQBQfZUxEZ7fTSjln++qeNoTdSxdZUZ3oO5oi2J1ha3yAKz
 RmzdulqSxiAY4RD1/Sy1YU70Itpjh+bwEkOlMHus0GElUO9bN1lpijebYFaRtcqceFtn
 E6WNiVbcjywGgrKp++w/t0/yr9pEoQxNB5eOCHY2qoacmXyQM/wyOYbeATMjHleOz+uq
 HjBuZ1c134O9pdRneSW52gcaYgSe3Yjb3eKAT0KV2ByOL23lMOEZDg3dUTSgRWdXqFrW
 HaN/Y5RYhGE2WPO+Ck2hCioYvTbckaavJvSmWKd1x3QidgcUeD4ddNjd10T3EJf+QfR9 hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d5e0b10f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Dec 2021 13:28:07 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BODOC4Q010275;
        Fri, 24 Dec 2021 13:28:06 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3d5e0b10en-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Dec 2021 13:28:06 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BODITci025079;
        Fri, 24 Dec 2021 13:28:05 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3d179abf08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Dec 2021 13:28:05 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BODJgDk44171616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Dec 2021 13:19:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6343F11C054;
        Fri, 24 Dec 2021 13:28:02 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADADA11C052;
        Fri, 24 Dec 2021 13:28:01 +0000 (GMT)
Received: from sig-9-65-66-205.ibm.com (unknown [9.65.66.205])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Dec 2021 13:28:01 +0000 (GMT)
Message-ID: <c3a1c7afed5962da2bf89d347fa5eea5fea40daf.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: silence measurement list hexdump during kexec
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 24 Dec 2021 08:28:01 -0500
In-Reply-To: <20211224131454.45577-1-bmeneg@redhat.com>
References: <20211224131454.45577-1-bmeneg@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sI6B3ix5sKMoiqYjIz_-g-tu-EwMxpKi
X-Proofpoint-GUID: LSqAM1gc3xMRAI_fwF-rSLtBudC1wneY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-24_04,2021-12-24_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112240064
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Bruno,

On Fri, 2021-12-24 at 10:14 -0300, Bruno Meneguele wrote:
> The measurement list is dumped during a soft reset (kexec) through the call
> to print_hex_dump(KERN_DEBUG, ...), printing to the system log ignoring both
> DEBUG build flag and CONFIG_DYNAMIC_DEBUG option.

Before upstreaming this patch, the reason for the config options "being
ignored", if that is really what is happening, needs to be understood
and documented here in the patch description.

thanks,

Mimi

> 
> To honor the above conditions the macro print_hex_dump_debug() should be
> used instead, thus depending on the enabled option/flag the output is given
> by a different function call or even silenced.
> 
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>

