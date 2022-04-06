Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A184F6CC5
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Apr 2022 23:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiDFVeL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Apr 2022 17:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiDFVeC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Apr 2022 17:34:02 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656721C137;
        Wed,  6 Apr 2022 13:46:40 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236JIo60013726;
        Wed, 6 Apr 2022 20:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=m96v/xVDd4vOarvxULRjnzqD3C6ItzSsq2ilLdDwCJc=;
 b=KgfQeX8u0bCBH4KxY4MXPpSAnT5g6ujpat8H9a8RTQfvRxc8+OaURvvSa64XeTQ+0pkm
 e77Lj7PCLpX/PyHQDeIaAJqFG4oSXpIj+qE8omIt872+7Vl20q2kRW5r+xqAYzPJI0i7
 8YXImzBtnueKfXp3hXBD2BV7shwqZ4QCu27At0eJz9DMFVGoREkew5GVXaS5IdQUDbbS
 OeuZ/su+CIEdfPIP8pulv9VAugLdt3moFS6mdgaJafZ6s/QBUrvDNKUD60ZLcPTmx6Zn
 wbKLddonD4Sb2niCQbGvNLEKxnNe4Zif3API++qFmJo4DxwKceY4DoFTqCY4bhcNe218 lg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f95vx8py9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 20:46:07 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 236Ka8Gr001302;
        Wed, 6 Apr 2022 20:46:06 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f95vx8pxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 20:46:06 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 236KhIGf027197;
        Wed, 6 Apr 2022 20:46:03 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 3f6e48xykh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Apr 2022 20:46:03 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 236Kk8me37814656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Apr 2022 20:46:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30DE152052;
        Wed,  6 Apr 2022 20:46:01 +0000 (GMT)
Received: from sig-9-65-95-173.ibm.com (unknown [9.65.95.173])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1F3055204E;
        Wed,  6 Apr 2022 20:45:59 +0000 (GMT)
Message-ID: <6bfe3fe98eb7c11520264503fd10da478d6a3fd3.camel@linux.ibm.com>
Subject: Re: [PATCH 0/7] Add CA enforcement keyring restrictions
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, dhowells@redhat.com,
        dwmw2@infradead.org, jarkko@kernel.org,
        linux-integrity@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        roberto.sassu@huawei.com, nramas@linux.microsoft.com,
        pvorel@suse.cz, tiwai@suse.de, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date:   Wed, 06 Apr 2022 16:45:58 -0400
In-Reply-To: <20220406015337.4000739-1-eric.snowberg@oracle.com>
References: <20220406015337.4000739-1-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j7oGSx8GYEFdafEibWGWHDms1J3qshLs
X-Proofpoint-ORIG-GUID: 1ZtL_67sM-Qxqi_1nqGwIY42WZNXI1xO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_12,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=855 phishscore=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

On Tue, 2022-04-05 at 21:53 -0400, Eric Snowberg wrote:
> A key added to the ima keyring must be signed by a key contained within 
> either the builtin trusted or secondary trusted keyrings. Currently, there are 
> CA restrictions described in IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY,
> but these restrictions are not enforced within code. Therefore, keys within 
> either the builtin or secondary may not be a CA and could be used to
> vouch for an ima key.
> 
> The machine keyring can not be used as another trust anchor for adding keys 
> to the ima keyring, since CA enforcement does not currently exist [1]. This 
> would expand the current integrity gap.
> 
> Introduce a new root of trust key flag to close this integrity gap for
> all keyrings.  The first key type to use this is X.509.  When a X.509 
> certificate is self signed, contains kernCertSign Key Usage and contains 
> the CA bit, the new flag is set.  Introduce new keyring restrictions 
> that not only validates a key is signed by a key contained within the 
> keyring, but also validates the key has the new root of trust key flag 
> set.  Use this new restriction for keys added to the ima keyring.  Now 
> that we have CA enforcement, allow the machine keyring to be used as another 
> trust anchor for the ima keyring.
> 
> To recap, all keys that previously loaded into the builtin, secondary or
> machine keyring will still load after applying this series.  Keys
> contained within these keyrings may carry the root of trust flag. The
> ima keyring will use the new root of trust restriction to validate
> CA enforcement. Other keyrings that require a root of trust could also 
> use this in the future.

Your initial patch set indicated that you were addressing Linus'
request to allow end-users the ability "to add their own keys and sign
modules they trust".  However, from the design of the previous patch
set and now this one, everything indicates a lot more is going on than
just allowing end-users to add their own keys.  There would be no
reason for loading all the MOK keys, rather than just the CA keys, onto
the "machine" keyring.  Please provide the motivation for this design.

Please note that Patch 6/7 permits intermediary CA keys, without any
mention of it in the cover letter.  Please include this in the
motivation for this design.

thanks,

Mimi

