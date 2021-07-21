Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C274F3D06BC
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 04:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbhGUBx1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Jul 2021 21:53:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21494 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230410AbhGUBxZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Jul 2021 21:53:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L2XQIr106099;
        Tue, 20 Jul 2021 22:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fTT1I93fQgiP8ZkYJtYgUx9Iuzny9/2QDdCSJ6H7Kac=;
 b=MHKa4qBIjhYLZoZguha8dKsoRdj8lZrdwbM/aRvPMklzTOoNg9s89SlegCsVr+rxVkDq
 porsQJbQAzVRvqkstn3jvW4q8q/MXfEQ81Hkzvd68vl6f/fhjE6ce5W0Uom0EyERodTV
 zbmLySfboBiiIMnyOIle4y+FIls7ZjrkVmg4DzScS5PdEzD6FXamupdjDYJxu1UiBVlb
 1745TkUhixPE/LdjKftP2V315qX1EF7YstT0I0Xafp7lh71rGPG1Lvft7PgFCbybdBQg
 SVdOubY4XMo8NWxKct4UottLYjAdqycWOG0fdYYzok0zitKZpWU9P1o3rzpX9WFD1K7U Fw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39x7yy3qw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 22:34:02 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16L2Y1QS108360;
        Tue, 20 Jul 2021 22:34:01 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39x7yy3quy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Jul 2021 22:34:01 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L2GN7w018099;
        Wed, 21 Jul 2021 02:33:59 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 39upfh8y75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 02:33:59 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L2VXW019530210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 02:31:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7893011C04A;
        Wed, 21 Jul 2021 02:33:55 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B71BD11C04C;
        Wed, 21 Jul 2021 02:33:53 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.1.44])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 02:33:53 +0000 (GMT)
Message-ID: <205b5336d60aee6b3f33ad67b2d0250e104d6779.camel@linux.ibm.com>
Subject: Re: [PATCH 7/7] dm: add documentation for IMA measurement support
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Cc:     linux-integrity@vger.kernel.org, nramas@linux.microsoft.com
Date:   Tue, 20 Jul 2021 22:33:52 -0400
In-Reply-To: <20210713004904.8808-8-tusharsu@linux.microsoft.com>
References: <20210713004904.8808-1-tusharsu@linux.microsoft.com>
         <20210713004904.8808-8-tusharsu@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yx0hiWVRiAWV9WTB5qASWo9qfWC702oM
X-Proofpoint-ORIG-GUID: bSuJgCNjNuyoQE09DKTHa7DqmzA-dGOk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-20_15:2021-07-19,2021-07-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 clxscore=1015
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Tushar, Mike,

On Mon, 2021-07-12 at 17:49 -0700, Tushar Sugandhi wrote:
> +Then IMA ASCII measurement log has the following format:
> +PCR TEMPLATE_DIGEST TEMPLATE ALG:EVENT_DIGEST EVENT_NAME EVENT_DATA
> +
> +PCR := Platform Configuration Register, in which the values are registered.
> +       This is applicable if TPM chip is in use.
> +TEMPLATE_DIGEST := Template digest of the IMA record.

^TEMPLATE_DATA_DIGEST

> +TEMPLATE := Template that registered the integrity value (e.g. ima-buf).

^TEMPLATE_NAME

The template data format consists of:
> +ALG:EVENT_DIGEST = Algorithm to compute event digest, followed by digest of event data
> +EVENT_NAME := Description of the event (e.g. 'table_load').
> +EVENT_DATA := The event data to be measured.

Missing from the document is a way of validating the template data. 
For example, in the original case of file measurements, the template
data contains the file hash, which can be recalculated or verified
against an allow list.

Other than re-calculating the template data digest based on the
template data, and verifying it against the template data digest in the
measurement list, would an attestation server be able to verify the
template data itself?

thanks,

Mimi

