Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8276A1D53
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Feb 2023 15:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjBXOQc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Feb 2023 09:16:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBXOQb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Feb 2023 09:16:31 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2053.outbound.protection.outlook.com [40.107.101.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1C199DB;
        Fri, 24 Feb 2023 06:16:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5nx/ELZx4j9Fp2e/iZhJpHwklFMhwjCeAuhrmQR7iN1/4E0ZaUJ2lN9yHnv9kZYnOxP1Z8dz8vKakNUqEp3YsD9sXUdCSVS4Gp41hKug3p0/ynkHY9J00K/i1VvQlyzrXfi3uUvLIF1CacpMxmnFhABJ1KQLBZiWziOULL/Zd/SMyQfTdCeLuWPoCuBfX2LX6A7aPzVdMg9pQsyEGNefR+Y7cUH5JuemmOJqqvKPYT7J6svR1kpjsjn+DkOpB8lXMj5okAzAvsGzpBdm2cENQ4lODJpsoznkkEjTJNXCpZmXKreDakLgc6dD2qk1gp/lrv4uoZZheVTWOlE48mkBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I6Cn234NeHxXAhN2zRGcJNK95xAEO5++u4rnfYpdb8M=;
 b=Y860ux4GpK7Y0D1xq4tpGNxFuB96NnVh5NVOfY3ChF039ivPH/+75twlR7u2oGMAKgGUzz+5uwbMdzIENsjxdirAkmoqS9R/5KrrPXYY0l42sZUEhCU0BlvAqUnw8F9UPictZhTa5fU5eybgCOsas9oTRZYOYO+rLAI+HQk3fd4y8xeCPBN1oYv+UK9yy6LDhwO4qwaBudEzqtL/+nmB0PsOPrjLybFb/OJ4Wb3a8UmcfImIidyFVX9iUcu/7frfrrn6RH7Vuw34yXIOQLY0Ko9b7mQf7fgGeB1Aez6DFuMd1S0oaPGH8e8rgvBxcHrCxTuNw5fiwJOSy8iG4c7pVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I6Cn234NeHxXAhN2zRGcJNK95xAEO5++u4rnfYpdb8M=;
 b=mvCGMCUXocgpAM957iDE6djtuHOHfblHklk0R8tMbfou4rxhU/lFGAZZBPnMbbfMoEMOwB+EqfnhAISNG2zvAqr2O4x6KDnDq7nz4U85ZYG67VbUyozam9DAFg1KWJSBKggPIUM+u7X/8J2VMOK7E6KJ1vsLRUfjAA6VsXSBgOBHj1XIk893Cp5Y2fXJKvSYWnhS+vixW2JV4utiBpRQPKAayE6DNDI9ryWIuLu2RCg4BPITR2rgAV5SnbnPeRbptscC53vDPnHWpO5sRAPUaim+18VGF/eOqcfiBBi05/tgFYNxaoEnKIKcT+RhDB5LbaySZdzOHbzs4QoHo1byaA==
Received: from DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) by
 DM6PR12MB4108.namprd12.prod.outlook.com (2603:10b6:5:220::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6111.21; Fri, 24 Feb 2023 14:16:28 +0000
Received: from DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0]) by DM4PR12MB5769.namprd12.prod.outlook.com
 ([fe80::bca7:6774:36b1:78a0%9]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 14:16:27 +0000
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: RE: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Thread-Topic: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
Thread-Index: AQHZR6OqOBQhj0zBTUWL/FYm6RTrP67cxooAgAAUpuCAAALmgIABQ3fw
Date:   Fri, 24 Feb 2023 14:16:27 +0000
Message-ID: <DM4PR12MB5769C60EFD807376CE09DC3FC3A89@DM4PR12MB5769.namprd12.prod.outlook.com>
References: <20230223162635.19747-1-kyarlagadda@nvidia.com>
 <20230223162635.19747-2-kyarlagadda@nvidia.com>
 <Y/egACRAp6nKZWdN@sirena.org.uk>
 <DM4PR12MB57695DE127286D1DA436E804C3AB9@DM4PR12MB5769.namprd12.prod.outlook.com>
 <Y/ezwaFCn5h86u6X@sirena.org.uk>
In-Reply-To: <Y/ezwaFCn5h86u6X@sirena.org.uk>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5769:EE_|DM6PR12MB4108:EE_
x-ms-office365-filtering-correlation-id: 5e958eac-a521-489c-adae-08db1671b7ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JU9I6kFbFgFbIlGUN7I1+TKgOX68qDAGmAa4C3PTDEj+2igk3GvIRvgntYomZIEVuM43q4BOz8Nyft+3pMtuwoxXyyqpmbWiScJ3D6z/4/8mg0NQ50XB6r+2V3tsHNRMb3wUZ8vCx5pSR5Zuq8FAqFyHdDisAMvbbgLBRBCzxwCeueR5jQ+yipxn9vQuFTiYo33O2jLN5w+H8EGIcfhmeDaENWFpXGw/Tv8CDGCUTZMgkLxuOqbJD9vIflr4DbIrBgLK7jHpp//VFqfl7MdKKyg5uCUAUaZg9QJI35sTB3+WsYwSWsGChKoL1zvOFUbrPWyEsGc3rR0YATqUt3JBw8liHLSKk8vWNcIO4ZS8olyVb3pf/gkibhMBxgSibhjhqJWwphEtDiTNMsy4Dy4AuGSaxEYEz8hZdCVbmKLsHGWQMeEZcSZTQRN66TwaU/38kZZbhiaFstwmxtYoZKFFMwDGA1/zd0okX+NgnKbqyRHatgre/dCVAzZrciffDKttkwuzz6T+Rgm29Q7BsgG3uivHJwbCJ7abi65ySJaVkCJvGxvTAQkOyYkSFL7IuHuDxBNmRU+Pgmzg2IV0nLi4iNkf476/jHoMD4Y9X04M+D+eQF1M5NuRw+guUsWooTb2tdR8jzxhjpGZz8YvkON4310IxIYqHPjIdieXJPRXXaiQRDIaR/UGM2udfEuLv8+iCuf2Yf3VK/eIhEn6Xwlu9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5769.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199018)(83380400001)(186003)(41300700001)(66446008)(9686003)(26005)(66476007)(54906003)(33656002)(316002)(7696005)(6506007)(86362001)(107886003)(53546011)(71200400001)(55016003)(38070700005)(478600001)(6916009)(8676002)(66556008)(64756008)(76116006)(4326008)(66946007)(122000001)(38100700002)(2906002)(7416002)(5660300002)(8936002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nL8CMnQTBqShGKR2LuSFZwXRzP0e8TNt9ZR516+/8tWGHgvxcWF93RW8UAE5?=
 =?us-ascii?Q?K8EiPj5dU3AaPjJPV/vZbMs2/ka74CDSu3zJJMlvZTYrX/Nmn2Q7QD23Mw/W?=
 =?us-ascii?Q?QMHSbA0+Lc0lPaJZxvBwzwSEo42qxHkQAf2Q9RGrAqaPzK6HsSdGTt0R4kXc?=
 =?us-ascii?Q?kouk4XCPlhaThL2uH10aQdYZrGVxNCXm2EiJiKf35T1KFNVC8EyT7JCMkyRt?=
 =?us-ascii?Q?t9DjDPmoDNtow0Pt6eIDYByaasLNragJlLcmA1Cw64LZ29AFoNIj65D+8skZ?=
 =?us-ascii?Q?WN0OxjA/PVDm5yBnZYv7yihvs80zmk62tpRzlkeVzIH4eDV6oClPlzs//1Ru?=
 =?us-ascii?Q?eeR+r0gfai1VJvALcnypbKzwLHaKEvuXdKufSt/hDfCc4OqOCwBVWqSB8h3l?=
 =?us-ascii?Q?ms4AH3xBTns1DJtioA9iwV4CA2MnxgeGcJ0A1f1aW5LIN0vyRcBuizPzsizC?=
 =?us-ascii?Q?KgLjgv4MF+QUsjWPgwhjhpG4KaZ0aXMWFpEo589wt2nMzKHgxBCZemnesKP6?=
 =?us-ascii?Q?oKy9Uu4qR2v20bONEp+mVG30xGbGPGoREiVe0NwFYdVTTDL3Y+9lq91+EPDC?=
 =?us-ascii?Q?RtEcPcMlugGI28TR/zOKNs3uxRAFe6GqRHzwktutT5U6ntqeSuz3QKUIxiIo?=
 =?us-ascii?Q?m4iCDGRUoDwilpVEH8YorsaSv2IWEzDb7YD4JUElqfFjZ/EedTY0Sf4u/gxA?=
 =?us-ascii?Q?Jpoe+mqpWJfPf3unCSs2MpeMw4uHMDcg42lUMsRY9T02qu5nhu0Q76uRiL2H?=
 =?us-ascii?Q?G6/iyk2b7jlr34l1SNs21F3EBDbTjYv66T71voE5yscFsFdBGEosw5r0QXPH?=
 =?us-ascii?Q?jQM8Bi03iJvy/SXxyYfRSfbS+01vTvIHCvUW3dLnuxz1FQMxQcZ4YVv+kS0X?=
 =?us-ascii?Q?JbOgEMo0e+Gl8xurZxwNcjMyk5Cpa0aBDfOsbTKrxBN6x9z6/THax6Ew7MEw?=
 =?us-ascii?Q?VzKffHJ/f1BxOxlBSdpf3OCDG6Xh86POWcO5BqooR+7oLkAohn8xOK7nZqID?=
 =?us-ascii?Q?MrBUo8HFTgJn989B2DVl1XDagiBI5Fz9/gMg5Ae6+4fPOboquSWvs5x4Qjxv?=
 =?us-ascii?Q?lxo48FXHOU6xbEPBAx4O+CuIuLkV0gLW/g7Cr7k0zVDPCLMxajbynYKT/Hx2?=
 =?us-ascii?Q?d4HNseCQbfIdfS8AE8dR6TM1Ajt+h4qBNxFfIzdFXMfL9dvZkFpfYjTOuABr?=
 =?us-ascii?Q?+MGkyiiaRI1dYAJ7gqmGkqrUBBis0MzIolAknNGG7wb1nblq5KDqO7TLSJIk?=
 =?us-ascii?Q?YGjZzueyOnbStYxqMkaDkFK3sz+qcO23k99GQscLhjiYmrgquBasP8cf0kSd?=
 =?us-ascii?Q?HAxGqe5fRVcBna1J5hDk5G8rqPDoP2NpvjWRTdrNMSXfS5vuN3ZoJL8vznEw?=
 =?us-ascii?Q?jyTFKwAsAbDIG5kshabbtv6sJkC3wNqSMGDD71AteGOh833Ab1cHC9I9Awjs?=
 =?us-ascii?Q?DrCwQ34Njz533sMuOqzpDq3PsY9+f+MI5WBspv8S0SPjxXAiuweVBzHS5Nzm?=
 =?us-ascii?Q?DoMRR9p+mallxJDYPtygLcRzuztjTLd85ZaQdfuAQTP/AacjSvv4FW5W9aOk?=
 =?us-ascii?Q?Y0BDfWQFLTxQBnxAWKUy9z2V0wW9jL2dG4H3aMIX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5769.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e958eac-a521-489c-adae-08db1671b7ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2023 14:16:27.5485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5BOSN35GSRueBYrubzTV0fQTpiPaawnpvhd86jhcrKkZOSNJv83XHB/cbK2PnEDwbczOaj34N2+XPhgw/tjE5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4108
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: 24 February 2023 00:13
> To: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> Cc: robh+dt@kernel.org; peterhuewe@gmx.de; jgg@ziepe.ca;
> jarkko@kernel.org; krzysztof.kozlowski+dt@linaro.org; linux-
> spi@vger.kernel.org; linux-tegra@vger.kernel.org; linux-
> integrity@vger.kernel.org; linux-kernel@vger.kernel.org;
> thierry.reding@gmail.com; Jonathan Hunter <jonathanh@nvidia.com>;
> Sowjanya Komatineni <skomatineni@nvidia.com>; Laxman Dewangan
> <ldewangan@nvidia.com>
> Subject: Re: [Patch V3 1/3] tpm_tis-spi: Support hardware wait polling
>=20
> On Thu, Feb 23, 2023 at 06:41:43PM +0000, Krishna Yarlagadda wrote:
>=20
> > > > +       spi_bus_lock(phy->spi_device->master);
> > > > +
> > > > +       while (len) {
>=20
> > > Why?
>=20
> > TPM supports max 64B in single transaction. Loop to send rest of it.
>=20
> No, why is there a bus lock?
Bus lock to avoid other clients to be accessed between TPM transfers.

>=20
> > > > +		spi_xfer[0].tx_buf =3D phy->iobuf;
> > > > +		spi_xfer[0].len =3D 1;
> > > > +		spi_message_add_tail(&spi_xfer[0], &m);
> > > > +
> > > > +		spi_xfer[1].tx_buf =3D phy->iobuf + 1;
> > > > +		spi_xfer[1].len =3D 3;
> > > > +		spi_message_add_tail(&spi_xfer[1], &m);
>=20
> > > Why would we make these two separate transfers?
>=20
> > Tegra QSPI combined sequence requires cmd, addr and data in different
> > transfers. This eliminates need for additional flag for combined sequen=
ce.
>=20
> That needs some documentation, and we might need a flag to ensure the
> core doesn't coalesce the transfers.
Will add comment at top of the function. Bus lock should avoid coalesce of
transfer of single message from others.
KY

