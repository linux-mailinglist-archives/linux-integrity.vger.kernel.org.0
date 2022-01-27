Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BBA49E531
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jan 2022 15:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242653AbiA0Ow7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Jan 2022 09:52:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242701AbiA0Ow6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Jan 2022 09:52:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20REg3Hm017937;
        Thu, 27 Jan 2022 14:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Yr8IgIpkJRS+CCsx/gVAlf3PpaBHoF4MFuTIopSDAM8=;
 b=YnO6jIXU3hCJss8d5kLMhzGHfmbMKUAu0cRjaIQyvzIyZPhyoaPw1AkAf71ULSN42bTB
 QDHD0nNPruZX9TYQl1DnV6Q5tVg8YVQzlRUQd7HZcQz8/fc5VsHzKiBem7GHeu0D/Dn+
 UP3pVAHCovlvhnpvq+JWIBlTJCNGEnDDTjUw3hZCK8KcP81pqW9tdxMe2WgiPvnlRomo
 lJUGYZyJfg2IkHG9fhsolAuifIbSpwx2iuQSJXpnfaCUz6U0AGxw21F28gLGjeyF1iVh
 3W2abYYBlbkfpNw3ZAaQI5GC7V98RQcHCvVFdW8H8zAzgklfgHHNj1ly2eMi0FPvn4+J 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3duvhe9p3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:52:54 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20REgV7S019908;
        Thu, 27 Jan 2022 14:52:54 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3duvhe9p2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:52:54 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20REpuKd014775;
        Thu, 27 Jan 2022 14:52:52 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3dr9j9q0t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 14:52:52 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20REhBuh39387466
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 14:43:11 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51AD54C046;
        Thu, 27 Jan 2022 14:52:49 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CBFA4C050;
        Thu, 27 Jan 2022 14:52:47 +0000 (GMT)
Received: from sig-9-65-89-165.ibm.com (unknown [9.65.89.165])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 27 Jan 2022 14:52:47 +0000 (GMT)
Message-ID: <76e7b1aa85c1ce2d147713306e5996eb55ba3987.camel@linux.ibm.com>
Subject: Re: [PATCH v8 1/3] certs: export load_certificate_list() to be used
 outside certs/
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, jarkko@kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me
Date:   Thu, 27 Jan 2022 09:52:47 -0500
In-Reply-To: <20220111183647.977037-2-nayna@linux.ibm.com>
References: <20220111183647.977037-1-nayna@linux.ibm.com>
         <20220111183647.977037-2-nayna@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EoXkdXQsPi_WAuXyhGKQxDE-Zo_uOkQs
X-Proofpoint-GUID: Ruf-JrV98J0oljczjZY1o49RpwwOQgV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270088
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On Tue, 2022-01-11 at 13:36 -0500, Nayna Jain wrote:
> load_certificate_list() parses certificates embedded in the kernel
> image to load them onto the keyring.
> 
> Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a common
> function)" made load_certificate_list() a common function in the certs/
> directory. Export load_certificate_list() outside certs/ to be used by
> load_platform_certificate_list() for loading compiled in platform keys
> onto the .platform keyring at boot time. 
> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>

I think Nayna addressed your concerns.  Did you want to upstream this
patch set or would you prefer I did?

thanks,

Mimi

