Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB986B9E5B
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Mar 2023 19:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCNS3X (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Mar 2023 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCNS3O (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Mar 2023 14:29:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DDA96C06;
        Tue, 14 Mar 2023 11:28:51 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32EGx4M5002703;
        Tue, 14 Mar 2023 18:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=MoBys2a5a2aIW+4UTVOsTIdo1J8fju5GYhkuW+NpRrs=;
 b=AhRn3PYDkXKDiEEBaHHLN05n34zaWMpzc5kzMtp78yAtviLF7q7NglMV53OqyZJ/ABZ/
 0ZmvWe7oOMki3VKYfO4unaX7Eo8r/fqIH+l2Sf+A6ljMz5q0tgv0iEqUIQ7n3wQwUbJH
 ivJ0qUFETPJhv9v9hjR/XVtuOr9o64/ciKODKHDwCxYQwGw00y8XOIRXiLKw9qjdNhUw
 XjwWq7KhoCrazef4UDUsNkuyge4OHYljFROQmc3cTsgJ22YXlG+SBbCnJ3oyYUOjl/FX
 DeeTXOytRxXkVVfHc1V1lKn60L48mcCi0zG7l9XyzQYg9UpJEORO907+pewMdOj4CI0i aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pampv303j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:28:33 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32EHlh6o037756;
        Tue, 14 Mar 2023 18:28:33 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3pampv303a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:28:33 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 32EICdbJ004888;
        Tue, 14 Mar 2023 18:28:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3p8h97tg1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Mar 2023 18:28:32 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32EISVVI39518754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Mar 2023 18:28:31 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AE8158066;
        Tue, 14 Mar 2023 18:28:31 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9540358043;
        Tue, 14 Mar 2023 18:28:29 +0000 (GMT)
Received: from sig-9-65-194-57.ibm.com (unknown [9.65.194.57])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Mar 2023 18:28:29 +0000 (GMT)
Message-ID: <ab1e29c1620ac492b9194b4c7a465b20cd39076a.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: allow/fix UML builds
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Rajiv Andrade <srajiv@linux.vnet.ibm.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Date:   Tue, 14 Mar 2023 14:28:29 -0400
In-Reply-To: <20230224032703.7789-1-rdunlap@infradead.org>
References: <20230224032703.7789-1-rdunlap@infradead.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DLevhJuZLcRgOUMV72YS6jyn3vaayjw1
X-Proofpoint-GUID: uMGPTO-j01lF7ok9TnXILXgamzP26jVA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-14_10,2023-03-14_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303140144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-02-23 at 19:27 -0800, Randy Dunlap wrote:
> UML supports HAS_IOMEM since 0bbadafdc49d (um: allow disabling
> NO_IOMEM).
> 
> Current IMA build on UML fails on allmodconfig (with TCG_TPM=m):
> 
> ld: security/integrity/ima/ima_queue.o: in function `ima_add_template_entry':
> ima_queue.c:(.text+0x2d9): undefined reference to `tpm_pcr_extend'
> ld: security/integrity/ima/ima_init.o: in function `ima_init':
> ima_init.c:(.init.text+0x43f): undefined reference to `tpm_default_chip'
> ld: security/integrity/ima/ima_crypto.o: in function `ima_calc_boot_aggregate_tfm':
> ima_crypto.c:(.text+0x1044): undefined reference to `tpm_pcr_read'
> ld: ima_crypto.c:(.text+0x10d8): undefined reference to `tpm_pcr_read'
> 
> Modify the IMA Kconfig entry so that it selects TCG_TPM if HAS_IOMEM
> is set, regardless of the UML Kconfig setting.
> This updates TCG_TPM from =m to =y and fixes the linker errors.
> 
> Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Indicating this resolves a commit which was upstreamed in linux-3.4,
while the fix for that commit 0bbadafdc49d ("um: allow disabling
NO_IOMEM") was upstreamed only in linux-5.14, leaves out an important
detail.

Is the proper way of indicating this disconnect by adding to the fixes
line the kernel?
Fixes: f4a0391dfa91 ("ima: fix Kconfig dependencies") # v5.14+

-- 
thanks,

Mimi


