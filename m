Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8772632E32
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Nov 2022 21:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKUUzA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Nov 2022 15:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiKUUy7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Nov 2022 15:54:59 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFA5C6566;
        Mon, 21 Nov 2022 12:54:58 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALKJGV7029147;
        Mon, 21 Nov 2022 20:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=7zCKX/4UjpQvenyrT8VZruRvalqRXYR6+icK2FwSEa4=;
 b=fjtgG3U2n53yDeBNWAZuAm3PDp2cFZ4R3+ps1ia+cUwJML1awN2FqbGANmzxLw3UJMYq
 Uu8+aG2GzpO8uIT0Z23sckf4UdI5xjyiqqRNgUTHRoe87JtPlu98IBi8JYfApYlSn2xi
 HpU8qBbTjKzIKFPZ9BY0rcnuAJloMtpYNnMm26B2pcgaQhMmzPvjty9uW+2L5BrRfvLQ
 gn5DTw7tKzTELyz8KJVaqGj1LZvCyv26ozGzuZmwB/tOniflRgcwcpYILFgyNjQ5uLc4
 0Et/aqTPAImeHW36i2Dut7UhGX0ppme5Vy7GGLwBjyKmYa5IvciD2rLbP14Hbfjvmg1y UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cfxxdpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:54:23 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2ALKpo1c018194;
        Mon, 21 Nov 2022 20:54:22 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3m0cfxxdph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:54:22 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2ALKp26j014761;
        Mon, 21 Nov 2022 20:54:22 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma05wdc.us.ibm.com with ESMTP id 3kxps9ysq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 20:54:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2ALKsHGE38994334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Nov 2022 20:54:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBA2C5805E;
        Mon, 21 Nov 2022 20:54:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2F1058043;
        Mon, 21 Nov 2022 20:54:19 +0000 (GMT)
Received: from sig-9-65-226-3.ibm.com (unknown [9.65.226.3])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 21 Nov 2022 20:54:19 +0000 (GMT)
Message-ID: <7812899531b2bd936b25fde8fc2f1c2a6080b2bd.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/5] security: Rewrite
 security_old_inode_init_security()
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org, casey@schaufler-ca.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        ocfs2-devel@oss.oracle.com
Date:   Mon, 21 Nov 2022 15:54:19 -0500
In-Reply-To: <aa5fa8c5f231115c58012352124df57d16a01e41.camel@huaweicloud.com>
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
         <20221110094639.3086409-3-roberto.sassu@huaweicloud.com>
         <3dc4f389ead98972cb7d09ef285a0065decb0ad0.camel@linux.ibm.com>
         <aa5fa8c5f231115c58012352124df57d16a01e41.camel@huaweicloud.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9ZpZWbYIju7_BhM44HScl-ON7UDQcqJB
X-Proofpoint-ORIG-GUID: HqentMrLUCV08LVMJ-qs-M3h27pvCp3p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-21_16,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211210155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2022-11-21 at 10:45 +0100, Roberto Sassu wrote:
> > As ocfs2 already defines initxattrs, that leaves only reiserfs missing
> > initxattrs().  A better, cleaner solution would be to define one.
> 
> If I understood why security_old_inode_init_security() is called
> instead of security_inode_init_security(), the reason seems that the
> filesystem code uses the length of the obtained xattr to make some
> calculations (e.g. reserve space). The xattr is written at a later
> time.
> 
> Since for reiserfs there is a plan to deprecate it, it probably
> wouldn't be worth to support the creation of multiple xattrs. I would
> define a callback to take the first xattr and make a copy, so that
> calling security_inode_init_security() + reiserfs_initxattrs() is
> equivalent to calling security_old_inode_init_security().
> 
> But then, this is what anyway I was doing with the
> security_initxattrs() callback, for all callers of security_old_inode_i
> nit_security().
> 
> Also, security_old_inode_init_security() is exported to kernel modules.
> Maybe, it is used somewhere. So, unless we plan to remove it
> completely, it should be probably be fixed to avoid multiple LSMs
> successfully setting an xattr, and losing the memory of all except the
> last (which this patch fixes by calling security_inode_init_security())
> .
> 
> If there is still the preference, I will implement the reiserfs
> callback and make a fix for security_old_inode_init_security().

There's no sense in doing both, as the purpose of defining a reiserfs
initxattrs function was to clean up this code making it more readable.

Mimi


