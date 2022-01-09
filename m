Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3BC488900
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Jan 2022 12:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbiAILti (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 9 Jan 2022 06:49:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60746 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230364AbiAILth (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 Jan 2022 06:49:37 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 209Bd09e014161;
        Sun, 9 Jan 2022 11:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=8h0dyO6ZGefPyVvITZczJl5MykXF2bf0VSLrgNBaNj8=;
 b=IbQEE4EkCpYExi5WBfoBGrs/Djry5hyxa/TLVaxVXneNh7M/bHXNCv8Enb3EMrs7gPq0
 JkLKbwhFvhAgkE61Zs+WszxkgnoxXca7RepKgN5chWf53AmOrpFMO4wv7J/f4y2vfW7Q
 rSzon8g7UGcZk6hHBqFpQ9xuO+7nKCbt7E7FqfALTh9quj3F0BA4kDdj3TSKnSczzOQ+
 dmrEiF6+m9rcVqItZ2UVPWzHxcWFCrgEpCZ/AcKD7YbSFRwHY/bnfKVsUbGgdINDooQD
 DXUAlq9usuo8+Klzsn35wz/coYvgHfwy7Uumc+zAZ0TJSLrq7jy6T0YPcA3ZzVpXIs3T 9A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm3uy7pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 11:49:30 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 209BnUOO001988;
        Sun, 9 Jan 2022 11:49:30 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dfm3uy7p6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 11:49:30 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 209BfYeu032033;
        Sun, 9 Jan 2022 11:49:27 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3df288wgrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 09 Jan 2022 11:49:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 209BeTaj48627992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 9 Jan 2022 11:40:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 689ADA405C;
        Sun,  9 Jan 2022 11:49:25 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C112AA405B;
        Sun,  9 Jan 2022 11:49:23 +0000 (GMT)
Received: from sig-9-65-83-86.ibm.com (unknown [9.65.83.86])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  9 Jan 2022 11:49:23 +0000 (GMT)
Message-ID: <4ba63271bdf06fa8ae98c5cbd60d7b91bdbe75f7.camel@linux.ibm.com>
Subject: Re: [PATCH v7 1/3] certs: export load_certificate_list() to be used
 outside certs/
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Nayna Jain <nayna@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        dhowells@redhat.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, kernel test robot <lkp@intel.com>
Date:   Sun, 09 Jan 2022 06:49:23 -0500
In-Reply-To: <YdmX2/BabFk2bNAv@iki.fi>
References: <20220105175410.554444-1-nayna@linux.ibm.com>
         <20220105175410.554444-2-nayna@linux.ibm.com> <YdmX2/BabFk2bNAv@iki.fi>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JHrsbk1oxW91h_D9QkNNHgq-_k7R3E05
X-Proofpoint-GUID: maFV3BWOXsas5gLuRHLsHUy7w-JLiAf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-09_04,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201090083
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On Sat, 2022-01-08 at 15:55 +0200, Jarkko Sakkinen wrote:
> On Wed, Jan 05, 2022 at 12:54:08PM -0500, Nayna Jain wrote:
> > load_certificate_list() parses certificates embedded in the kernel
> > image to load them onto the keyring.
> > 
> > Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> > function)" made load_certificate_list() a common function in the certs/
> > directory. Now, export load_certificate_list() outside certs/ to be used
> > by load_platform_certificate_list() which is added later in the patchset.
> 
> Also, please describe the specific use it will be used. Patchset is not
> a valid cross-reference in this context.

The specific usecase scenario is described in the cover letter.  Is
that what you're looking for?

thanks,

Mimi

